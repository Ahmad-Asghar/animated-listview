
import 'package:flutter/material.dart';

class AppColors{


  static Color primaryColor = Color(0xff195bff);
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color lightGreyColor = Color(0xfff7f7f7);
  static Color ratingColor = Color(0xfff9a629);



  static Gradient appGradient =  LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight ,
    colors: [
      Color(0xFF4a63f0), // Coral Pink
      Color(0xFFda67df), // Peach Orange
      Color(0xFFf4a77f), // Soft Blue
      Color(0xFFe37fbb), // Aqua Mint
    ],
    stops: [0.0, 0.45, 0.75, 1.0],
  );

}