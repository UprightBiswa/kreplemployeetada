import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/pending_tour_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/model/create_tour_plan_model.dart';

class PendingTourPlan extends StatelessWidget {
  const PendingTourPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CreateTourPlanModel> pendingTours = dummyTourPlan
        .where((tour) => tour.status == TourStatus.pending)
        .toList();

    return ListView.separated(
        itemCount: pendingTours.length,
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          return PendingTourCard(
            pendingTours: pendingTours[index],
          );
        });
  }
}
