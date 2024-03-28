import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import Get package for navigation
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/menus/all_menus_view.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/button_animation.dart';

class SearchButton extends StatelessWidget {
  final String? buttonText;

  const SearchButton({Key? key, this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Get.to(() => const AllPages()); // Navigate to the desired page
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color:
              isDarkMode(context) ? AppColors.kContentColor : AppColors.kInput,
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                buttonText ?? 'Search',
                style: isDarkMode(context)
                    ? AppTypography.kMedium12.copyWith(color: AppColors.kWhite)
                    : AppTypography.kMedium12.copyWith(color: AppColors.kGrey),
              ),
            ),
            ButtonAnimation(
              onTap: () => Get.to(() => const AllPages()),
              child: Container(
                  padding: EdgeInsets.all(9.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.kPrimary,
                  ),
                  child: SvgPicture.asset(AppAssets.kSearch)),
            ),
          ],
        ),
      ),
    );
  }
}
