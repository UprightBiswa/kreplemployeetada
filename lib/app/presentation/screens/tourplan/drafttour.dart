import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/draft_tour_card.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/model/create_tour_plan_model.dart';

class DraftTourPlan extends StatelessWidget {
  const DraftTourPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CreateTourPlanModel> draftTours =
        dummyTourPlan.where((tour) => tour.status == TourStatus.draft).toList();
    return ListView.separated(
        itemCount: draftTours.length,
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          return DraftTourCard(
            draftTours: draftTours[index],
          );
        });
  }
}
