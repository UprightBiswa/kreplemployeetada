import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/booking_model.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/components/booking_service_card.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/components/status_card.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/fade_animations.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';

class DraftBookingCard extends StatelessWidget {
  final BookingModel booking;
  const DraftBookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
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
              Text('Schedule', style: AppTypography.kLight14),
              const Spacer(),
              Text('8:00-9:00 AM, Dec 9', style: AppTypography.kLight14),
            ],
          ),
        ],
      )),
    );
  }
}
