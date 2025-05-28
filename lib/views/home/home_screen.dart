import 'package:animated_listview/views/home/widgets/home_appbar.dart';
import 'package:animated_listview/views/home/widgets/recently_added_widget.dart';
import 'package:animated_listview/views/home/widgets/search_bar.dart';
import 'package:animated_listview/views/home/widgets/upgrade_to_pro_widget.dart';
import 'package:animated_listview/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/app/const/app_colors.dart';
import '../../repos/products_repo.dart';
import '../detail/details_screen.dart';
import 'package:flutter_rating/flutter_rating.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h,),
        HomeAppbar(),
        SizedBox(height: 1.2.h),
        CustomSearchBar(),
        SizedBox(height: 1.2.h),
        UpgradeToProWidget(),
        SizedBox(height: 1.2.h),
        RecentlyAddedWidget(),
        SizedBox(height: 1.h),
        Expanded(
          child: ListView.builder(
            padding:  EdgeInsets.symmetric(horizontal: 15),
            itemCount: ProductsRepoModel.sliderList.length,
            itemBuilder: (context, index) {
              GlobalKey key = GlobalKey();
              String tag = 'imageTag$index';
              String textTag = 'textTag$index';
              return GestureDetector(
                onTap: () {
                  final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
                  final size = renderBox.size;
                  final offset = renderBox.localToGlobal(Offset.zero);

                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 700), // slow hero animation duration
                      reverseTransitionDuration: Duration(milliseconds: 700), // slow on pop as well
                      pageBuilder: (context, animation, secondaryAnimation) => DetailsScreen(
                        itemModel: ProductsRepoModel.sliderList[index],
                        startSize: size,
                        startPosition: offset,
                        index: index,
                      ),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation.drive(
                            Tween(begin: 0, end: 1),
                          ),
                          child: child,
                        );
                      },

                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      key: key,
                      height: 20.h,
                      width: double.infinity,
                      child: Hero(
                        tag: tag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            ProductsRepoModel.sliderList[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.3.h),
                    Hero(
                      tag: textTag,
                      child: CustomTextWidget(
                        title: 'Beautiful large room with private bathroom',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.5.sp,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          title: 'Room in House',
                          fontSize: 14.5.sp,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextWidget(
                              title: '\$200',
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomTextWidget(
                              title: ' /per month',
                              fontSize: 14.5.sp,
                            ),

                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidget(
                          title: 'Wallstreet, California',
                          fontSize: 14.8.sp,
                        ),
                        StarRating(
                          size: 17,
                          rating: 4,
                          color: AppColors.ratingColor,
                          allowHalfRating: false,
                          onRatingChanged: (rating) {

                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 1.5.h)
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

