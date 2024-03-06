
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/model/booking_model.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/components/upcoming_booking_card.dart';

class UpComingBookings extends StatelessWidget {
  const UpComingBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: upcomingBookings.length,
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          return  UpComingBookingCard(
            bookings: upcomingBookings[index],
          );
        });
  }
}
