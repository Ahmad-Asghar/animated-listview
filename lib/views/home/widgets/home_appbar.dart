import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/app/const/app_colors.dart';
import '../../../common/app/const/app_images.dart';
import '../../../widgets/app_text.dart';
class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 21.sp,
                backgroundImage: AssetImage(AppImages.user),
              ),
              SizedBox(width: 7,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(title: "Hello John",fontSize: 15.5.sp,height: 1.1,),
                  Row(
                    children: [
                      CustomTextWidget(title: "California,USA",fontSize: 15.sp,),
                      Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.appGradient
                ),
                height: 25.sp,
                width: 25.sp,
                child: Center(
                  child: SvgPicture.asset(
                    height: 26,
                    AppImages.subscribe,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lightGreyColor
                    ),
                    height: 25.sp,
                    width: 25.sp,
                    child: Center(
                      child: SvgPicture.asset(
                        height: 26,
                        AppImages.notification,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 6.5,
                    backgroundColor: Colors.red,
                    child: CustomTextWidget(title: '2',fontSize: 11.sp,color: AppColors.white),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
