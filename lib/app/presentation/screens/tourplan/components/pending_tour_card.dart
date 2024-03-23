import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/tour_status_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/model/create_tour_plan_model.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/view_tourplan_details.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/fade_animations.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';

class PendingTourCard extends StatelessWidget {
  final CreateTourPlanModel pendingTours;
  const PendingTourCard({super.key, required this.pendingTours});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ViewTourPlanDetails(
              viewtourPlan: pendingTours,
            ));
      },
      child: FadeInAnimation(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: PrimaryContainer(
            child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 55.h,
                  width: 55.w,
                  padding: EdgeInsets.all(17.h),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFFFBC99)),
                  child: SvgPicture.asset(AppAssets.kTour),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pendingTours.employeeName,
                        style: AppTypography.kMedium16),
                    SizedBox(height: 5.h),
                    Text(
                      'EMP Code: #${pendingTours.employeeNumber}',
                      style: AppTypography.kLight14
                          .copyWith(color: AppColors.kNeutral),
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 25.h),
            Row(
              children: [
                Text('Status', style: AppTypography.kLight14),
                const Spacer(),
                TourStatusCard(
                  status: pendingTours.status,
                )
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  height: 45.h,
                  width: 45.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.kInput)),
                  child: SvgPicture.asset(
                    AppAssets.kDate,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kGrey, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${pendingTours.selectedStartDate}',
                        style: AppTypography.kMedium14),
                    Text('${pendingTours.selectedStartTime}',
                        style: AppTypography.kMedium14),
                    Text('Start Date - Time',
                        style: AppTypography.kLight12
                            .copyWith(color: AppColors.kNeutral04))
                  ],
                )
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  height: 45.h,
                  width: 45.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.kInput)),
                  child: SvgPicture.asset(
                    AppAssets.kDate,
                    colorFilter: const ColorFilter.mode(
                        AppColors.kGrey, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${pendingTours.selectedEndDate}',
                        style: AppTypography.kMedium14),
                    Text('${pendingTours.selectedEndTime}',
                        style: AppTypography.kMedium14),
                    Text('End Date - Time',
                        style: AppTypography.kLight12
                            .copyWith(color: AppColors.kNeutral04))
                  ],
                )
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  height: 45.h,
                  width: 45.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.kInput),
                  ),
                  child:
                      Image.asset(pendingTours.selectedObjects?[0].image ?? ''),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tour Type: ${pendingTours.tourType}',
                          style: AppTypography.kMedium14),
                      Text(
                          'Total Selected Objects: ${pendingTours.selectedObjects?.length ?? 0}',
                          style: AppTypography.kLight12
                              .copyWith(color: AppColors.kNeutral04))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  height: 45.h,
                  width: 45.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.kInput),
                  ),
                  child:
                      Image.asset(pendingTours.selectedPurpose?[0].image ?? ''),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Purpose Type: ${pendingTours.tourType}',
                          style: AppTypography.kMedium14),
                      Text(
                          'Selected Purpose: ${pendingTours.selectedPurpose?[0].name ?? ''}',
                          style: AppTypography.kLight12
                              .copyWith(color: AppColors.kNeutral04))
                    ],
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
