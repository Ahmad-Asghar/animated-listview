import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../provider/animated_route_provider.dart';
import '../repos/products_repo.dart';
import '../widgets/custom_hero.dart';
import 'details_screen.dart';


class ListviewScreen extends StatelessWidget {
  const ListviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: ProductsRepoModel.sliderList.length,
        itemBuilder: (context, index) {
          GlobalKey key = GlobalKey();
          String tag = 'imageTag$index';
          return GestureDetector(
            onTap:(){
              final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
              final size = renderBox.size;
              final offset = renderBox.localToGlobal(Offset.zero);
              Navigator.of(context).push(createRoute(
                DetailsScreen(
                  itemModel: ProductsRepoModel.sliderList[index],
                  startSize: size,
                  startPosition: offset,
                ),
              ));
            },
            child: Container(
              key: key,
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 25.h,
              child: CustomHero(
                tag: tag,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOutBack,
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
    );
  }
}



// class DetailScreen extends StatelessWidget {
//   final String imagePath;
//   final String tag;
//
//   const DetailScreen({
//     super.key,
//     required this.imagePath,
//     required this.tag,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);  // Pops back to ListviewScreen with reverse hero animation
//           },
//           child: Center(
//             child: CustomHero(
//               tag: tag,
//               duration: const Duration(milliseconds: 1000),
//               curve: Curves.easeInOutBack,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.contain,
//                   height: 100.h,
//                   width: 100.w,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }