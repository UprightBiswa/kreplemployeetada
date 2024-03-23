import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';

class NewProductsCard extends StatelessWidget {
  const NewProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: isDarkMode(context)
              ? AppColors.kSecondary
              : const Color(0xFFEAF6EF),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Offer AC Service', style: AppTypography.kMedium13),
                SizedBox(width: 10.w),
                SvgPicture.asset(AppAssets.kInfo)
              ],
            ),
            SizedBox(height: 5.h),
            Text('Get 25%', style: AppTypography.kBold20),
            const Spacer(),
            CustomButton(
                text: 'Grab Offer', icon: AppAssets.kArrowForward, onTap: () {})
          ],
        ));
  }
}
