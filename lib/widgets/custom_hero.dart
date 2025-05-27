import 'dart:ui';

import 'package:flutter/material.dart';

class CustomHero extends StatefulWidget {
  final Widget child;
  final String tag;
  final Duration duration;
  final Curve curve;

  const CustomHero({
    Key? key,
    required this.child,
    required this.tag,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  static final Map<String, _HeroEntry> _heroEntries = {};

  static void pushHero(BuildContext context, String tag, Widget destination) {
    final heroEntry = _heroEntries[tag];
    if (heroEntry == null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => destination),
      );
      return;
    }

    final overlay = Overlay.of(context);
    final renderBox = heroEntry.key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final startOffset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return _HeroOverlayAnimation(
          child: heroEntry.child,
          startOffset: startOffset,
          startSize: size,
          destination: destination,
          duration: heroEntry.duration,
          curve: heroEntry.curve,
        );
      },
    );

    overlay.insert(overlayEntry);
  }

  @override
  State<CustomHero> createState() => _CustomHeroState();
}

class _CustomHeroState extends State<CustomHero> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    CustomHero._heroEntries[widget.tag] = _HeroEntry(
      key: _key,
      child: widget.child,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  @override
  void dispose() {
    CustomHero._heroEntries.remove(widget.tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}

class _HeroEntry {
  final GlobalKey key;
  final Widget child;
  final Duration duration;
  final Curve curve;

  _HeroEntry({
    required this.key,
    required this.child,
    required this.duration,
    required this.curve,
  });
}

class _HeroOverlayAnimation extends StatefulWidget {
  final Widget child;
  final Offset startOffset;
  final Size startSize;
  final Widget destination;
  final Duration duration;
  final Curve curve;

  const _HeroOverlayAnimation({
    required this.child,
    required this.startOffset,
    required this.startSize,
    required this.destination,
    required this.duration,
    required this.curve,
  });

  @override
  State<_HeroOverlayAnimation> createState() => _HeroOverlayAnimationState();
}

class _HeroOverlayAnimationState extends State<_HeroOverlayAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    _controller.forward().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => widget.destination),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final top = lerpDouble(widget.startOffset.dy, 0, _animation.value)!;
        final left = lerpDouble(widget.startOffset.dx, 0, _animation.value)!;
        final width = lerpDouble(widget.startSize.width, screenSize.width, _animation.value)!;
        final height = lerpDouble(widget.startSize.height, screenSize.height, _animation.value)!;

        return Positioned(
          top: top,
          left: left,
          width: width,
          height: height,
          child: Material(
            color: Colors.transparent,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
