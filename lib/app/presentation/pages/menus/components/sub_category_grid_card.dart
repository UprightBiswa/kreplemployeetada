import 'package:animations/animations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/product_model.dart';
import 'package:kreplemployee/app/presentation/pages/menus/components/rating_widget.dart';
import 'package:kreplemployee/app/presentation/pages/products/product_detail_view.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/heart_animation.dart';

class SubCategoryGridCard extends StatefulWidget {
  final ProductsModel service;

  const SubCategoryGridCard({Key? key, required this.service})
      : super(key: key);

  @override
  State<SubCategoryGridCard> createState() => _SubCategoryGridCardState();
}

class _SubCategoryGridCardState extends State<SubCategoryGridCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (BuildContext _, VoidCallback openContainer) {
          return ServicesDetailView(services: widget.service);
        },
        middleColor: isDarkMode(context)
            ? AppColors.kDarkSurfaceColor
            : AppColors.kWhite,
        openColor: isDarkMode(context)
            ? AppColors.kDarkSurfaceColor
            : AppColors.kWhite,
        closedColor: isDarkMode(context)
            ? AppColors.kDarkSurfaceColor
            : AppColors.kWhite,
        closedShape: const RoundedRectangleBorder(),
        closedElevation: 0.0,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          return GestureDetector(
            onTap: openContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 147.w,
                  height: 158.h,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: AssetImage(widget.service.image),
                        fit: BoxFit.cover,
                      )),
                  child: HeartAnimationWidget(
                    isAnimating: isFavorite,
                    duration: const Duration(milliseconds: 150),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        color: isFavorite ? Colors.red : AppColors.kWhite,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(widget.service.name, style: AppTypography.kMedium14),
                SizedBox(height: 4.h),
                Text('Starts From',
                    style: AppTypography.kLight12.copyWith(
                        color: AppColors.kNeutral04.withOpacity(0.75))),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 4.5.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: AppColors.kLime,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Text('\$ ${widget.service.price}',
                          style: AppTypography.kMedium12),
                    ),
                    const Spacer(),
                    SecondaryRatingWidget(service: widget.service)
                  ],
                )
              ],
            ),
          );
        });
  }
}
