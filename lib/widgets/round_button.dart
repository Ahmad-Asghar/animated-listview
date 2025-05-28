import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/app/const/app_colors.dart';
import '../common/app/const/app_images.dart';


class RoundButton extends StatelessWidget {
  final String iconImage;
  final Function() onTap;
  const RoundButton({super.key, required this.iconImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGreyColor
        ),
        height: 25.sp,
        width: 25.sp,
        child: Center(
          child: SvgPicture.asset(
            height: 22,
            iconImage,
          ),
        ),
      ),
    );
  }
}
