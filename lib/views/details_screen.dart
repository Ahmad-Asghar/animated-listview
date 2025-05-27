import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../repos/products_repo.dart';
import '../widgets/app_text.dart';

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

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  double _dragStartY = 0.0;
  bool _isDragging = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  VoidCallback? _onReturnCallback;

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
      return Alignment.center;
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
            double newScale = (1 - (dragDistance / 350)).clamp(0.65, 1.0);
            setState(() {
              _scale = newScale;
            });
          }
        },
        onVerticalDragEnd: (details) {
          _isDragging = false;
          _handleDragEnd();
        },
        child: Transform.scale(
          scale: _scale,
          alignment: _getCurrentAlignment(),
          child: ClipRRect(
            borderRadius:
            !_isDragging ? BorderRadius.zero : BorderRadius.circular(20),
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
                          horizontal: 3.w, vertical: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: const Icon(
                                Icons.chevron_left_rounded,
                                size: 35,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: const Icon(
                                Icons.favorite,
                                size: 27,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    width: 100.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWidget(
                                      title: widget.itemModel.name,
                                      fontSize: 6.w,
                                    ),
                                    CustomTextWidget(
                                      title: widget.itemModel.brandName,
                                      color: Colors.blueGrey,
                                      fontSize: 5.w,
                                    ),
                                  ],
                                ),
                                CustomTextWidget(
                                  title:
                                  '\$${widget.itemModel.price.toString()}',
                                  color: const Color(0xffdf5130),
                                  fontSize: 10.w,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            CustomTextWidget(
                              color: Colors.blueGrey,
                              title: widget.itemModel.description,
                            ),
                            SizedBox(height: 3.h),
                            SizedBox(
                              width: double.infinity,
                              height: 7.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: const Color(0xffdf5130),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {},
                                child: CustomTextWidget(
                                  title: 'Add to Cart',
                                  fontSize: 5.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWidget(
                                      title: widget.itemModel.name,
                                      fontSize: 6.w,
                                    ),
                                    CustomTextWidget(
                                      title: widget.itemModel.brandName,
                                      color: Colors.blueGrey,
                                      fontSize: 5.w,
                                    ),
                                  ],
                                ),
                                CustomTextWidget(
                                  title:
                                  '\$${widget.itemModel.price.toString()}',
                                  color: const Color(0xffdf5130),
                                  fontSize: 10.w,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWidget(
                                      title: widget.itemModel.name,
                                      fontSize: 6.w,
                                    ),
                                    CustomTextWidget(
                                      title: widget.itemModel.brandName,
                                      color: Colors.blueGrey,
                                      fontSize: 5.w,
                                    ),
                                  ],
                                ),
                                CustomTextWidget(
                                  title:
                                  '\$${widget.itemModel.price.toString()}',
                                  color: const Color(0xffdf5130),
                                  fontSize: 10.w,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
