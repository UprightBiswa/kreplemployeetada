import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/model/create_tour_plan_model.dart';

class TourStatusCard extends StatelessWidget {
  final TourStatus status;
  const TourStatusCard({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color containerColor;
    Color textColor;

    switch (status) {
      case TourStatus.approved:
        containerColor = AppColors.kPrimary.withOpacity(0.1);
        textColor = AppColors.kPrimary;
        break;
      case TourStatus.pending:
         containerColor = const Color(0xFFEB833C).withOpacity(0.1);
        textColor = AppColors.kAccent1;
        break;
      case TourStatus.draft:
        containerColor = AppColors.kAccent1.withOpacity(0.1);
        textColor = AppColors.kAccent1;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        status.name.capitalizeFirst.toString(),
        style: AppTypography.kMedium14.copyWith(color: textColor),
      ),
    );
  }
}
