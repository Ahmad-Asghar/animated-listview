import 'package:animated_listview/views/home/widgets/home_appbar.dart';
import 'package:animated_listview/views/home/widgets/search_bar.dart';
import 'package:animated_listview/views/home/widgets/upgrade_to_pro_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../repos/products_repo.dart';
import '../details_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h,),
          HomeAppbar(),
          SizedBox(height: 1.5.h),
          CustomSearchBar(),
          SizedBox(height: 1.5.h),
          UpgradeToProWidget(),
          SizedBox(height: 1.5.h),
          Expanded(
            child: ListView.builder(
              padding:  EdgeInsets.symmetric(horizontal: 15),
              itemCount: ProductsRepoModel.sliderList.length,
              itemBuilder: (context, index) {
                GlobalKey key = GlobalKey();
                String tag = 'imageTag$index';
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
            
                  child: Container(
                    key: key,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 25.h,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

