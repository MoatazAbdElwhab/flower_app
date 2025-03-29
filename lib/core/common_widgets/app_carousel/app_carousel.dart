import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '../app_network_image/app_network_image.dart';

class AppCarousel extends StatefulWidget {
  final List<String> networkImages;
  final double? height;
  const AppCarousel({super.key, required this.networkImages, this.height});
  @override
  State<AppCarousel> createState() => _State();
}

class _State extends State<AppCarousel> {
  int _currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.networkImages.map((image) {
            return SizedBox(
              width: double.infinity,
              height: widget.height ?? MediaQuery.sizeOf(context).height * 0.5,
              child: AppNetworkImage(networkImage: image),
            );
          }).toList(),
          options: CarouselOptions(
            height: widget.height ?? MediaQuery.of(context).size.height * 0.5,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.networkImages.map((image) {
            int index = widget.networkImages.indexOf(image);
            return Container(
              width: 10.w,
              height: 10.h,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentImageIndex == index
                    ? AppColors.primary
                    : Colors.grey.shade300,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
