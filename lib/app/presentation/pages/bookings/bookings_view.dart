import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/draft_bookings.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/history_booking.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/upcoming_booking.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({
    super.key,
  });

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppSpacing.twentyHorizontal),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              CustomHeaderText(
                  text: 'Bookings',
                  fontColor:
                      isDarkMode(context) ? AppColors.kWhite : Colors.black),
              SizedBox(height: 20.h),
              PrimaryContainer(
                padding: EdgeInsets.all(10.h),
                child: const TabBar(
                  tabs: [
                    Tab(
                      text: 'Upcoming',
                    ),
                    Tab(
                      text: 'History',
                    ),
                    Tab(
                      text: 'Draft',
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    UpComingBookings(),
                    HistoryBookings(),
                    DraftBookings(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
