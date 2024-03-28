import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/user_details_model.dart';

class ProfileImageCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? textColor;
  final UserDetails userDetails;

  const ProfileImageCard({
    this.textColor,
    required this.onTap,
    required this.userDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSpacing.radiusThirty,
            backgroundImage: AssetImage(
              AppAssets.kLogo,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userDetails.employeeName,
                style: AppTypography.kMedium15.copyWith(
                  color: textColor ??
                      (isDarkMode(context)
                          ? AppColors.kWhite
                          : AppColors.kWhite),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'ID: ${userDetails.employeeCode}',
                style: AppTypography.kLight14.copyWith(color: AppColors.kHint),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
