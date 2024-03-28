import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/product_model.dart';
import 'package:kreplemployee/app/data/model/user_details_model.dart';
import 'package:kreplemployee/app/presentation/pages/products/components/search_button.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/home_services_card.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class BookingsView extends StatefulWidget {
  final UserDetails userDetails;
  const BookingsView({
    super.key,
    required this.userDetails,
  });

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CustomHeaderText(
                text: 'Find your Products',
                fontColor:
                    isDarkMode(context) ? AppColors.kWhite : Colors.black),
            SizedBox(height: 20.h),
            PrimaryContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello Krepl Employee 👋',
                      style: AppTypography.kMedium14
                          .copyWith(color: AppColors.kGrey)),
                  SizedBox(height: 14.h),
                  // Text('What you are looking for today',
                  //     style: AppTypography.kBold32),
                  // SizedBox(height: 14.h),
                  const SearchButton(
                    buttonText: 'Search for products, brands and more',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: AssetImage(AppAssets.kProductsBanner),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            PrimaryContainer(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.h),
                      child: Row(
                        children: [
                          CustomHeaderText(
                            text: 'All Products',
                            fontSize: 18.sp,
                          ),
                          const Spacer(),
                          CustomButton(
                              text: 'See All',
                              icon: AppAssets.kArrowForward,
                              isBorder: true,
                              onTap: () {})
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 195.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 16.w),
                          itemBuilder: (context, index) {
                            return HomeServicesCard(
                              service: acRepair[index],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16.w),
                          itemCount: acRepair.length),
                    ),
                    SizedBox(height: 16.h),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
