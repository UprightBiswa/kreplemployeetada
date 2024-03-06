import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/category_model.dart';
import 'package:kreplemployee/app/data/model/services_model.dart';
import 'package:kreplemployee/app/presentation/pages/categories/all_categories_view.dart';
import 'package:kreplemployee/app/presentation/pages/categories/components/category_card.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/home_services_card.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/offers_list.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/search_field.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            PrimaryContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello Krepl Employee 👋',
                    style: AppTypography.kMedium14
                        .copyWith(color: AppColors.kGrey)),
                SizedBox(height: 4.h),
                Text('What you are looking for today',
                    style: AppTypography.kBold32),
                SizedBox(height: 14.h),
                SearchField(
                  controller: _searchController,
                  onSearchPress: () {},
                ),
              ],
            )),
            SizedBox(height: 16.h),
            const OfferList(),
            SizedBox(height: 16.h),
            PrimaryContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  if (index == 3) {
                    return CategorySeeAllButton(onTap: () {
                      Get.to(() => const AllCategories());
                    });
                  } else {
                    return CategoryCard(
                      category: categories[index],
                    );
                  }
                }),
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
                            text: 'Cleaning Services',
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
                              service: cleaningServices[index],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16.w),
                          itemCount: cleaningServices.length),
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
