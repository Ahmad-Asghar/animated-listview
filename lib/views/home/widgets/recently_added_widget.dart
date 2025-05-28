import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../widgets/app_text.dart';

class RecentlyAddedWidget extends StatelessWidget {
  const RecentlyAddedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(title: "Recently Added",fontWeight: FontWeight.w600,),
          CustomTextWidget(title: "1030 properties",fontSize: 14.5.sp,),
        ],
      ),
    );
  }
}
