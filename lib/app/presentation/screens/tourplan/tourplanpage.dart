import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/draft_bookings.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/history_booking.dart';
import 'package:kreplemployee/app/presentation/pages/bookings/upcoming_booking.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/createtourplanpage.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/button_animation.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class TourPlanPage extends StatelessWidget {
  const TourPlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tour Plan Page'),
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppSpacing.twentyHorizontal),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomHeaderText(
                    text: 'Tour Plan',
                    fontColor:
                        isDarkMode(context) ? AppColors.kWhite : Colors.black,
                  ),
                  ButtonAnimation(
                    child: Container(
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                          color: AppColors.kPrimary,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppAssets.kAdd),
                          SizedBox(width: 5.w),
                          Text('New Tour',
                              style: AppTypography.kMedium15
                                  .copyWith(color: AppColors.kWhite))
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.to(() => const CreateTourPlanPage());
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              PrimaryContainer(
                padding: EdgeInsets.all(10.h),
                child: const TabBar(
                  tabs: [
                    Tab(
                      text: 'Recent',
                    ),
                    Tab(
                      text: 'Approved',
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
