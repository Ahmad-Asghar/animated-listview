import 'package:animate_do/animate_do.dart';
import 'package:animated_listview/views/detail/widgets/facilities_check_tile.dart';
import 'package:animated_listview/views/detail/widgets/glass_icon_button.dart';
import 'package:animated_listview/views/detail/widgets/property_detail_tile.dart';
import 'package:animated_listview/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/app/const/app_colors.dart';
import '../../common/app/const/app_images.dart';
import '../../repos/products_repo.dart';
import '../../widgets/app_text.dart';
import '../../widgets/round_button.dart';

class DetailsScreen extends StatefulWidget {
  final ProductsRepoModel itemModel;
  final Size startSize;
  final Offset startPosition;
  final int index;

  const DetailsScreen({
    super.key,
    required this.startSize,
    required this.startPosition,
    required this.itemModel,
    required this.index,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin {

  double _scale = 1.0;
  double _dragStartY = 0.0;
  bool _isDragging = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  VoidCallback? _onReturnCallback;

  final List<String> facilities= [
    'In-Unit Laundry',
    'Street Parking',
    'Cat Friendly',
    'Dog Friendly',
    'Children Friendly',
    'Private entrance',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: _scale, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addListener(() {
      setState(() {
        _scale = _scaleAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragEnd() {
    if (_scale <= 0.85) {
      if (_onReturnCallback != null) {
        _onReturnCallback!();
      } else {
        Navigator.pop(context);
      }
    } else {
      _scaleAnimation = Tween<double>(begin: _scale, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
      _controller.forward(from: 0.0);
    }
  }

  Alignment _getCurrentAlignment() {
    if (_isDragging) {
      return Alignment.bottomCenter;
    } else {
      final screenSize = MediaQuery.of(context).size;
      return Alignment(
        (widget.startPosition.dx / screenSize.width) * 2 - 1,
        (widget.startPosition.dy / screenSize.height) * 2 - 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragStart: (details) {
          _isDragging = true;
          _dragStartY = details.globalPosition.dy;
        },
        onVerticalDragUpdate: (details) {
          if (_isDragging) {
            double dragDistance = details.globalPosition.dy - _dragStartY;
            double newScale = (1 - (dragDistance / 700)).clamp(0.8, 1.0);
            setState(() {
              _scale = newScale;
            });
          }
        },
        onVerticalDragEnd: (details) {
          _isDragging = false;
          _handleDragEnd();
        },
        child: Padding(
          padding:  EdgeInsets.only(bottom: _isDragging?5.h:0),
          child: Transform.scale(
            scale: _scale,
            alignment: _getCurrentAlignment(),
            child: ClipRRect(
              borderRadius:
              !_isDragging ? BorderRadius.zero : BorderRadius.circular(30),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: 'imageTag${widget.index}',
                        child: Container(
                          width: 100.w,
                          height:25.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.itemModel.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GlassIconButton(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(AppImages.arrowBack, height: 18),
                            ),
                            GlassIconButton(
                              onTap: () {},
                              child: SvgPicture.asset(AppImages.more, height: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 80.w
                                  ),
                                  child: Hero(
                                      tag: 'textTag${widget.index}',
                                      child: CustomTextWidget(
                                        title: 'Beautiful large room with private bathroom',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.5.sp,
                                      )),
                                ),
                                FadeInRight(child: RoundButton(iconImage: AppImages.favourite, onTap: () {  })),
                              ],
                            ),
                            FadeInUp(child: CustomTextWidget(title: '1192 North 16th St. Tampa, fl 33612')),
                            FadeInUp(
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      CustomTextWidget(title: '\$200',fontSize: 16.sp,color: AppColors.primaryColor,fontWeight: FontWeight.w600),
                                      CustomTextWidget(title: ' /per month',color: AppColors.greyTextColor),
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Container(height: 14,width: 1.6,color: Colors.blueGrey.withOpacity(0.3),),
                                  SizedBox(width: 10,),
                                  Row(
                                    children: [
                                      CustomTextWidget(title: 'Deposit: ',color: AppColors.greyTextColor),
                                      CustomTextWidget(title: '\$200',fontSize: 16.sp,color: AppColors.primaryColor,fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            SizedBox(height: .5.h,),
                            FadeInLeft(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18.sp,
                                    backgroundImage: AssetImage(AppImages.user),
                                  ),
                                  SizedBox(width: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomTextWidget(title: "Property Owner",fontSize: 14.5.sp),
                                          SizedBox(width: 5,),
                                          CircleAvatar(radius: 3,backgroundColor: AppColors.black,),
                                          SizedBox(width: 5,),
                                          CustomTextWidget(title: "Ali Raza",fontSize: 14.5.sp,fontWeight: FontWeight.w600,),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomTextWidget(title: "Hosting for",fontSize: 14.sp),
                                          SizedBox(width: 5,),
                                          CircleAvatar(radius: 2,backgroundColor: AppColors.black,),
                                          SizedBox(width: 5,),
                                          CustomTextWidget(title: "3 years",fontSize: 13.5.sp),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: .8.h,),
                            FadeInRight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Row(
                                    children: [
                                      StarRating(
                                        size: 17,
                                        rating: 4,
                                        color: AppColors.ratingColor,
                                        allowHalfRating: false,
                                        onRatingChanged: (rating) {

                                        },
                                      ),
                                      SizedBox(width: 5,),
                                      CustomTextWidget(title: '4.0 (140 reviews)',fontSize: 14.sp,fontWeight: FontWeight.w600,)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(radius: 3,backgroundColor: AppColors.greenColor,),
                                      SizedBox(width: 5,),
                                      CustomTextWidget(title: 'Available',fontSize: 14.sp,fontWeight: FontWeight.w600,)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 1.h,),
                            FadeInUp(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                               width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: AppColors.appGradient
                              ),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: AppColors.white.withOpacity(0.2),
                                      child: CircleAvatar(
                                        radius: 31,
                                        backgroundColor: AppColors.white.withOpacity(0.3),
                                        child: CircleAvatar(
                                          radius: 22,
                                          backgroundColor: AppColors.white,
                                          child: SvgPicture.asset(AppImages.locked)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1.h,),
                                    CustomTextWidget(title: "Early Bird Access",fontWeight: FontWeight.bold,fontSize: 17.sp,color: AppColors.white,),
                                    CustomTextWidget(
                                      height: 1.3,
                                      textAlign: TextAlign.center,
                                      title: "User Ad is New and less then 7 days old. You’ll need to upgrade",color: AppColors.white,),
                                    SizedBox(height: 1.h,),
                                    CustomButton(
                                      backgroundColor: AppColors.white,
                                        text: "Upgrade to Contact",
                                      borderRadius: 50,

                                    )

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h,),
                            CustomTextWidget(title: "Property Details",fontSize: 15.sp,fontWeight: FontWeight.w600),
                            PropertyDetailTile(title: 'Property Type:', description: 'House'),
                            PropertyDetailTile(title: 'No. of Rooms:', description: '3 Bed, 2 Baths'),
                            PropertyDetailTile(title: 'Furnished:', description: 'Yes'),
                            PropertyDetailTile(title: 'Bathroom:', description: 'Shared Bathroom'),
                            PropertyDetailTile(title: 'Roommates:', description: '2 Roommates (1 male,1 female)'),
                            PropertyDetailTile(title: 'Landlord:', description: 'Resident Landlord'),
                            PropertyDetailTile(title: 'Utilities Included:', description: 'Yes'),
                            PropertyDetailTile(title: 'Lease:', description: 'Long term'),
                            PropertyDetailTile(title: 'Available:', description: 'Feb 6th, 2025'),
                            PropertyDetailTile(title: 'overnight guest :', description: 'Yes'),
                            Divider(),
                            CustomTextWidget(title: "Location",fontSize: 15.sp,fontWeight: FontWeight.w600),
                            SizedBox(height: 1.h,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              height: 18.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: AssetImage('assets/images/map.png'),fit: BoxFit.cover)
                            ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.white
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(AppImages.location),
                                          SizedBox(width: 10,),
                                          CustomTextWidget(title: 'Tampa, Florida'),
                                        ],
                                      ),
                                      SvgPicture.asset(AppImages.direction),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h,),
                            CustomTextWidget(title: "Description",fontSize: 15.sp,fontWeight: FontWeight.w600),
                            SizedBox(height: 0.6.h,),
                            CustomTextWidget(
                              title: "This is a great place to reside in, having an area with a good number of shopping places and schools. The apartment is cozy and all utility supplies readily accessible. Serene and fortified living has become a must when it comes to securing a permanent address in a busy city like Dhaka. ",
                              fontSize: 14.2.sp,
                            ),
                            SizedBox(height: 1.h,),
                            CustomTextWidget(title: "Facilities",fontSize: 15.sp,fontWeight: FontWeight.w600),
                            SizedBox(height: 0.6.h,),
                            SizedBox(
                              height: 12.h,
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: facilities.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 5.8,
                                      crossAxisCount: 2
                                  ),
                                  itemBuilder: (context,index){
                                    return FacilitiesCheckTile(title: facilities[index], isSuccess: index!=1);
                                  }
                              ),
                            ),
                            SizedBox(height: 1.h,),
                            CustomButton(
                              backgroundColor: AppColors.primaryColor,
                              text: "Request viewing",
                              borderRadius: 50,
                              textColor: AppColors.white,

                            ),
                            SizedBox(height: 1.h,),
                            CustomButton(
                              backgroundColor: AppColors.lightGreyColor,
                              text: "Message",
                              borderRadius: 50,

                            ),
                            SizedBox(height: 10.h,),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
