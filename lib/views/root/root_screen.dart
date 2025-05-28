import 'package:animated_listview/views/home/home_screen.dart';
import 'package:animated_listview/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app/const/app_colors.dart';
import '../../common/app/const/app_images.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 7.3.h,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RootItem(
              image: AppImages.home,
              title: 'Home',
              onTap: () {
                setState(() {
                  selectedScreen = 0;
                });
              },
              isSelected: selectedScreen==0,
            ),
            RootItem(
              image: AppImages.messages,
              title: 'Inbox',
              onTap: () {
                setState(() {
                  selectedScreen = 1;
                });
              },
              isSelected: selectedScreen==1,
            ),
            RootItem(
              image: AppImages.favourite,
              title: 'Favorites',
              onTap: () {
                setState(() {
                  selectedScreen = 2;
                });
              },
              isSelected: selectedScreen==2,
            ),
            RootItem(
              image: AppImages.profile,
              title: 'Profile',
              onTap: () {
                setState(() {
                  selectedScreen = 3;
                });
              },
                isSelected: selectedScreen==3,
            ),
          ],
        ),
      ),
      body: HomeScreen(),
    );
  }
}

class RootItem extends StatelessWidget {
  final String image;
  final String title;
  final Function() onTap;
  final bool isSelected;
  const RootItem({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Column(
        children: [
          SvgPicture.asset(
            image,
            color: isSelected ? AppColors.primaryColor : AppColors.black,
          ),
          CustomTextWidget(
            title: title,
            fontSize: 13.sp,
            color: isSelected ? AppColors.primaryColor : AppColors.black,
          ),
        ],
      ),
    );
  }
}
