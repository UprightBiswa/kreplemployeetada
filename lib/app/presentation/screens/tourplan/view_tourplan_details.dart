import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/menus/components/date_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/custom_expanded_tile.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/selected_type_view.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/tour_status_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/edit_tour_plan_page.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/model/create_tour_plan_model.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class ViewTourPlanDetails extends StatelessWidget {
  final CreateTourPlanModel viewtourPlan;

  const ViewTourPlanDetails({Key? key, required this.viewtourPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tour Plan Details'),
        actions: [
          TourStatusCard(
            status: viewtourPlan.status,
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            PrimaryContainer(
              child: Row(
                children: [
                  CustomHeaderText(text: 'EMP Code:', fontSize: 18.sp),
                  SizedBox(width: 5.w),
                  Text(
                    viewtourPlan.employeeName,
                    style: AppTypography.kBold16
                        .copyWith(color: const Color(0xFFFC944D)),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            PrimaryContainer(
              child: Row(
                children: [
                  CustomHeaderText(text: 'EMP Id:', fontSize: 18.sp),
                  SizedBox(width: 5.w),
                  Text(
                    viewtourPlan.employeeNumber,
                    style: AppTypography.kBold16
                        .copyWith(color: const Color(0xFFFC944D)),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            CustomExpandedTile(title: 'Date and Time', children: [
              DateCard(
                onTap: null,
                icon: AppAssets.kDate,
                color: null,
                title: 'Start Date:',
                subtitle:
                    '${viewtourPlan.selectedStartDate}\n-${viewtourPlan.selectedStartTime}',
              ),
              SizedBox(height: 10.h),
              DateCard(
                onTap: null,
                icon: AppAssets.kTime,
                color: null,
                title: 'End Date:',
                subtitle:
                    '${viewtourPlan.selectedStartDate}\n-${viewtourPlan.selectedStartTime}',
              ),
            ]),
            SizedBox(height: 16.h),
            CustomExpandedTile(
              title: 'Tour Type: ${viewtourPlan.tourType}',
              children: [
                SelectedItemView(
                  title: viewtourPlan.tourType,
                  selectedItems: viewtourPlan.selectedObjects!,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            CustomExpandedTile(
              title:
                  'Tour Purpose: ${viewtourPlan.selectedPurpose?[0].name ?? ''}',
              children: [
                SelectedItemView(
                  title: viewtourPlan.selectedPurpose?[0].name ?? '',
                  selectedItems: viewtourPlan.selectedPurpose!,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            CustomExpandedTile(
              title: 'Remarks:',
              children: [
                CustomHeaderText(text: viewtourPlan.remarks, fontSize: 18.sp),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
      bottomSheet: Container(
        color: isDarkMode(context) ? Colors.black : AppColors.kWhite,
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            PrimaryButton(
              onTap: () {
                Get.to(
                  () => EditTourPlanPage(tourPlan: viewtourPlan),
                );
              },
              text: 'Edit Tour Plan',
              color: isDarkMode(context)
                  ? AppColors.kContentColor
                  : AppColors.kWhite,
              isBorder: true,
            ),
          ],
        ),
      ),
    );
  }
}
