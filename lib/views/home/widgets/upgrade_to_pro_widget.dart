import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/app/const/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_button.dart';


class UpgradeToProWidget extends StatelessWidget {
  const UpgradeToProWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 8.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: AppColors.appGradient
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                CustomTextWidget(title: 'Upgrade to Pro',color: AppColors.white,fontSize: 16.5.sp,fontWeight: FontWeight.bold,),
                SizedBox(height: 2,),
                Container(
                    constraints: BoxConstraints(maxWidth: 55.w),
                    child: CustomTextWidget(
                      maxLines: 2,
                      height: 1.1,
                      title: 'Subscribe to NextRoom and unlock premium features!',
                      color: AppColors.white,
                      fontSize: 13.sp,
                    )),
              ],
            ),
            CustomButton(
              borderRadius: 25,
              height: 4.7.h,
              backgroundColor: AppColors.white,
              text: 'Upgrade',
              textColor: AppColors.black,
            )
          ],
        ),
      ),
    );
  }
}
