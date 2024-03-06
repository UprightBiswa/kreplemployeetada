
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/booking_model.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/components/booking_service_card.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/components/status_card.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/history_bookings_detail.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/fade_animations.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';

class HistoryBookingCard extends StatelessWidget {
  final BookingModel booking;
  const HistoryBookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HistoryBookingsDetail(
              bookings: booking,
            ));
      },
      child: FadeInAnimation(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: PrimaryContainer(
            child: Column(
          children: [
            BookingServiceCard(booking: booking),
            Divider(height: 25.h),
            Row(
              children: [
                Text('Status', style: AppTypography.kLight14),
                const Spacer(),
                BookingStatusCard(status: booking.status)
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Text('Service Provider', style: AppTypography.kLight14),
                const Spacer(),
                Text('Westinghouse', style: AppTypography.kLight14),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Text('Schedule', style: AppTypography.kLight14),
                const Spacer(),
                Text('8:00-9:00 AM, Dec 9', style: AppTypography.kLight14),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
