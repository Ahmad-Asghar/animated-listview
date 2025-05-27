import 'package:flutter/material.dart';

class CustomAnimatedContainer extends StatefulWidget {
  final Size startSize;
  final Offset startPosition;
  final Size endSize;
  final Curve curve;
  final Widget Function(
      BuildContext context,
      Size size,
      Offset position,
      bool animationCompleted,
      VoidCallback? onReturnCallMethod,
      ) builder;

  const CustomAnimatedContainer({
    super.key,
    required this.startSize,
    required this.startPosition,
    required this.endSize,
    this.curve = Curves.easeInOut,
    required this.builder,
  });

  @override
  CustomAnimatedContainerState createState() => CustomAnimatedContainerState();
}

class CustomAnimatedContainerState extends State<CustomAnimatedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Size> _sizeAnimation;
  late Animation<Offset> _positionAnimation;
  bool _animationCompleted = false;

  double _dragOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _setupAnimations(widget.startSize, widget.startPosition, widget.startSize, widget.startPosition);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animationCompleted = true;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupAnimations(widget.startSize, widget.startPosition, widget.endSize, Offset.zero);
      _controller.forward();
    });
  }

  void _setupAnimations(Size beginSize, Offset beginPosition, Size endSize, Offset endPosition) {
    _sizeAnimation = Tween<Size>(begin: beginSize, end: endSize).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _positionAnimation = Tween<Offset>(begin: beginPosition, end: endPosition).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> reverseAnimation() async {
    setState(() {
      _animationCompleted = false;
    });
    await _controller.reverse();
  }

  Future<void> popWithAnimation() async {
    await reverseAnimation();
    Navigator.pop(context);
  }

  Future<bool> _onWillPop() async {
    await reverseAnimation();
    return true;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (!_animationCompleted) return;

    setState(() {
      _dragOffset += details.delta.dy;

      // Limit drag offset to 0 and positive values only
      if (_dragOffset < 0) _dragOffset = 0;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    double threshold = 150; // Customize pop threshold

    if (_dragOffset > threshold) {
      popWithAnimation();
    } else {
      // Animate back to original position
      setState(() {
        _dragOffset = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final baseSize = _sizeAnimation.value;
          final basePosition = _positionAnimation.value;

          // Calculate size and position adjustments based on drag
          double dragFactor = (_dragOffset / 300).clamp(0, 0.4); // Max shrink factor
          final currentSize = Size(
            baseSize.width * (1 - dragFactor),
            baseSize.height * (1 - dragFactor),
          );
          final currentPosition = Offset(
            basePosition.dx,
            basePosition.dy + _dragOffset,
          );

          return GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            child: widget.builder(context, currentSize, currentPosition, _animationCompleted, popWithAnimation),
          );
        },
      ),
    );
  }
}
