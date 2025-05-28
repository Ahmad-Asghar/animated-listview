import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app/const/app_images.dart';
import '../../../widgets/app_text.dart';

class FacilitiesCheckTile extends StatelessWidget {
  final String title;
  final bool isSuccess;

  const FacilitiesCheckTile({super.key, required this.title, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset( isSuccess?AppImages.tickMark:AppImages.crossMark),
        SizedBox(width: 10),
        CustomTextWidget(title: title)
      ],
    );
  }
}
