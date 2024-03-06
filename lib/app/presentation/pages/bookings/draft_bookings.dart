
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/model/booking_model.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/components/draft_booking_card.dart';

class DraftBookings extends StatelessWidget {
  const DraftBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: draftsBookings.length,
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          return DraftBookingCard(
            booking: draftsBookings[index],
          );
        });
  }
}
