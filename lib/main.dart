import 'package:animated_listview/views/home/home_screen.dart';
import 'package:animated_listview/views/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return  MaterialApp(
          home: RootScreen(),
          debugShowCheckedModeBanner: false
      );
    });
  }
}
