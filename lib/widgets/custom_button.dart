import 'package:animated_listview/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double borderRadius;
  final double height;
  final VoidCallback? onTap;

  const CustomButton({
    Key? key,
    required this.text,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.blue,
    this.borderRadius = 12.0,
    this.height = 50.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: Colors.white.withOpacity(0.3), // Optional: customize splash
        highlightColor: Colors.transparent,
        child: Container(
          height: height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextWidget(
           title:  text,
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
    );
  }
}
