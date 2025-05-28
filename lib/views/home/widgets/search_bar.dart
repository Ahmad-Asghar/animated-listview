import 'package:animated_listview/common/app/const/app_images.dart';
import 'package:animated_listview/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 5),
      height: 6.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
         color: Color(0xfff6f6f6)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Center(
                  child: SvgPicture.asset(AppImages.search),
                ),
              ),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    title: "Search",
                    fontWeight: FontWeight.w600,
                  ),
                  Container(
                    height: 15,
                    constraints: BoxConstraints(maxWidth: 50.w),
                    child: IntrinsicWidth(
                      child: IntrinsicHeight(
                        child: TextFormField(
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp
                        ),
                          textAlignVertical: TextAlignVertical.top,
                          cursorHeight: 10,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14.sp
                            ),
              
                            hintText: 'Location, City, Apartment, House',
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
              
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(onPressed: (){}, icon: SvgPicture.asset(AppImages.filter))

        ],
      ),
    );
  }
}
