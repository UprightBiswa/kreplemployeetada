
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/tour_type_model.dart';

class PlanTypeCard extends StatelessWidget {
  final TourType tourtype;
  final VoidCallback onTap;
  final bool isSelected;
  const PlanTypeCard(
      {super.key,
      required this.tourtype,
      required this.onTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 65.h,
            width: 65.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: isSelected ? AppColors.kPrimary : null,
                border: isSelected ? null : Border.all(color: AppColors.kHint)),
            child: SvgPicture.asset(
              tourtype.image,
              colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.kWhite : AppColors.kHint,
                  BlendMode.srcIn),
            ),
          ),
          SizedBox(height: 10.h),
          Text(tourtype.name, style: AppTypography.kLight13)
        ],
      ),
    );
  }
}
