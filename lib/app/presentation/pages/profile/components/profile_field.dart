import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const ProfileField({
    Key? key,
    required this.label,
    required this.value,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isDarkMode(context) ? AppColors.kWhite : Colors.black,
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              label,
              style: AppTypography.kMedium15,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
            color: isDarkMode(context) ? AppColors.kGrey : AppColors.kHint,
          ),
          child: Text(
            value,
            style: AppTypography.kMedium14.copyWith(
              color: isDarkMode(context) ? AppColors.kWhite : Colors.black,
            ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
