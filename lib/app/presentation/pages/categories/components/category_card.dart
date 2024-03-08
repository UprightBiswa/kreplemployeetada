import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/category_model.dart';
import 'package:kreplemployee/app/presentation/pages/categories/sub_category_view.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/tourplanpage.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/button_animation.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final bool isGridView;
  const CategoryCard({
    required this.category,
    this.isGridView = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonAnimation(
      onTap: () {
       switch (category.pageName) {
        case 'TourPlanPage':
          Get.to(() => const TourPlanPage());
          break;
        case 'BeautyPage':
         // Get.to(() => BeautyPage());
          break;
        case 'AppliancePage':
         // Get.to(() => AppliancePage());
          break;
        // Add more cases for other pages as needed
        default:
          // Navigate to SubCategoryView by default
          Get.to(() => SubCategoryView(category: category));
          break;
      }
      },
      child: Column(
        children: [
          Container(
            height: isGridView ? 72.h : 58.h,
            width: isGridView ? 72.h : 58.h,
            alignment: Alignment.center,
            padding: EdgeInsets.all(18.h),
            decoration: BoxDecoration(
              color: category.color,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(category.image),
          ),
          SizedBox(height: 12.h),
          Text(category.name, style: AppTypography.kLight13),
        ],
      ),
    );
  }
}

class CategorySeeAllButton extends StatelessWidget {
  final VoidCallback onTap;
  const CategorySeeAllButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return ButtonAnimation(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 58.h,
            width: 58.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDarkMode(context)
                  ? AppColors.kContentColor
                  : const Color(0xFFECECEC),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_forward),
          ),
          SizedBox(height: 12.h),
          Text('See All', style: AppTypography.kLight13),
        ],
      ),
    );
  }
}
