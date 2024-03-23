import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/new_products_card.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class NewProductList extends StatelessWidget {
  const NewProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.h),
              child: Row(
                children: [
                  CustomHeaderText(
                    text: 'New products',
                    fontSize: 18.sp,
                  ),
                  const Spacer(),
                  CustomButton(
                      text: 'See All',
                      icon: AppAssets.kArrowForward,
                      isBorder: true,
                      onTap: () {})
                ],
              ),
            ),
            SizedBox(
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 150.h,
                    autoPlay: true,
                    viewportFraction: 0.9,
                    autoPlayAnimationDuration: const Duration(seconds: 2)),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return const NewProductsCard();
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ));
  }
}
