import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/approved_tour_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/model/create_tour_plan_model.dart';

class ApprovedTourPlan extends StatelessWidget {
  const ApprovedTourPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CreateTourPlanModel> approvedTours = dummyTourPlan
        .where((tour) => tour.status == TourStatus.approved)
        .toList();
    return ListView.separated(
        itemCount: approvedTours.length,
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          return ApprovedTourCard(
            approvedTours: approvedTours[index],
          );
        });
  }
}
