import 'dart:ui';
import 'package:flutter/material.dart';

class FullScreenGlassBlur extends StatelessWidget {
  const FullScreenGlassBlur({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.zero, // No rounded corners for fullscreen
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
