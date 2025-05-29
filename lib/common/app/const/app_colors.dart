import 'package:flutter/material.dart';

class AppColors{

  static Color primaryColor = Color(0xff195bff);
  static Color lightGreyColor = Color(0xfff7f7f7);
  static Color greyTextColor = Color(0xff666666);
  static Color ratingColor = Color(0xfff9a629);
  static Color greenColor = Color(0xff44e12c);

  static Color white = Colors.white;
  static Color black = Colors.black;

  static Gradient appGradient =  LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight ,
    colors: [
      Color(0xFF4a63f0),
      Color(0xFFda67df),
      Color(0xFFf4a77f),
      Color(0xFFe37fbb),
    ],
    stops: [0.0, 0.45, 0.75, 1.0],
  );

}