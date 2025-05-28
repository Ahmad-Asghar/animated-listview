import 'package:flutter/material.dart';

import '../../../common/app/const/app_colors.dart';
import '../../../widgets/app_text.dart';

class PropertyDetailTile extends StatelessWidget {
  final String title;
  final String description;
  const PropertyDetailTile({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(title: title,color: AppColors.greyTextColor,),
          CustomTextWidget(title: description,),
        ],
      ),
    );
  }
}
