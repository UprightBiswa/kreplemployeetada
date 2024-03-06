import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/helper/controller/menucontroller.dart';
import 'package:kreplemployee/app/logic/controllers/theme_controller.dart';
import 'package:kreplemployee/app/presentation/pages/address/address_view.dart';
import 'package:kreplemployee/app/presentation/pages/calendar/calendar_view.dart';
import 'package:kreplemployee/app/presentation/pages/landing_pages/landing_pages.dart';
import 'package:kreplemployee/app/presentation/pages/notifications/notification_view.dart';
import 'package:kreplemployee/app/presentation/pages/profile/components/profile_image_card.dart';
import 'package:kreplemployee/app/presentation/pages/profile/profile_view.dart';
import 'package:kreplemployee/app/presentation/pages/support/support_view.dart';
import 'package:kreplemployee/app/presentation/screens/offers/offers_view.dart';
import 'package:kreplemployee/app/presentation/widgets/drawer/side_menu.dart';
import 'package:kreplemployee/app/presentation/widgets/drawer/toogle_button.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final SelectMenuController menuController = Get.put(SelectMenuController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor:
          isDarkMode(context) ? AppColors.kDarkInput : AppColors.kPrimary,
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppSpacing.twentyHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              ProfileImageCard(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 100))
                      .then((value) {
                    Get.back();
                    Get.to(() => const ProfileView());
                  });
                },
              ),
              SizedBox(height: 50.h),
              SideMenu(
                onPressed: () {
                   menuController.setSelectedMenuIndex(0);
                  Future.delayed(const Duration(milliseconds: 500))
                      .then((value) {
                    Get.back();
                    Get.to(() => const LandingPage());
                  });
                },
                icon: AppAssets.kCalendar,
               isSelected: menuController.selectedMenuIndex.value == 0,
                text: 'Home',
              ),
              SizedBox(height: 5.h),
              SideMenu(
                onPressed: () {
                   menuController.setSelectedMenuIndex(1);
                  Future.delayed(const Duration(milliseconds: 500))
                      .then((value) {
                    Get.back();
                    Get.to(() => const CalendarView());
                  });
                },
                icon: AppAssets.kCalendar,
                isSelected: menuController.selectedMenuIndex.value == 1,
                text: 'Calendar',
              ),
              SizedBox(height: 5.h),
              SideMenu(
                onPressed: () {
                 menuController.setSelectedMenuIndex(1);
                  Future.delayed(const Duration(milliseconds: 500))
                      .then((value) {
                    Get.back();
                    Get.to(() => const AddressView());
                  });
                },
                icon: AppAssets.kAddress,
                isSelected: menuController.selectedMenuIndex.value == 1,
                text: 'Address',
              ),
              SizedBox(height: 5.h),
              SideMenu(
                onPressed: () {
                 menuController.setSelectedMenuIndex(1);
                  Future.delayed(const Duration(milliseconds: 500))
                      .then((value) {
                    Get.back();
                    Get.to(() => const NotificationView());
                  });
                },
                icon: AppAssets.kNotification,
                isSelected: menuController.selectedMenuIndex.value == 1,
                text: 'Notifications',
              ),
              SizedBox(height: 5.h),
              SideMenu(
                onPressed: () {
                 menuController.setSelectedMenuIndex(1);
                  Future.delayed(const Duration(milliseconds: 500))
                      .then((value) {
                    Get.back();
                    Get.to(() => const OffersView());
                  });
                },
                icon: AppAssets.kOffers,
               isSelected: menuController.selectedMenuIndex.value == 1,
                text: 'Offers',
              ),
              SizedBox(height: 5.h),
              SideMenu(
                onPressed: () {
                  menuController.setSelectedMenuIndex(1);
                  Future.delayed(const Duration(milliseconds: 500))
                      .then((value) {
                    Get.back();
                    Get.to(() => const SupportView());
                  });
                },
                icon: AppAssets.kSupport,
               isSelected: menuController.selectedMenuIndex.value == 1,
                text: 'Support',
              ),
              SizedBox(height: 5.h),
              // SideMenu(
              //   onPressed: () {
              //     setState(() {
              //       selectedMenu = 7;
              //     });
              //     showGeneralDialog(
              //         barrierColor: Colors.black.withOpacity(0.5),
              //         transitionBuilder: (context, a1, a2, widget) {
              //           return RatingDialog(
              //             opacity: a1,
              //             scale: a1,
              //           );
              //         },
              //         transitionDuration: const Duration(milliseconds: 200),
              //         barrierDismissible: true,
              //         barrierLabel: '',
              //         context: context,
              //         pageBuilder: (context, animation1, animation2) {
              //           return const SizedBox();
              //         });
              //   },
              //   icon: AppAssets.kStar,
              //   isSelected: selectedMenu == 7,
              //   text: 'Rate Us',
              // ),
              const Spacer(),
              const Divider(
                color: AppColors.kHint,
              ),
              SideMenu(
                isSelected: false,
                icon: AppAssets.kHelp,
                text: 'Color Scheme',
              ),
              GetBuilder<ThemeController>(
                init: ThemeController(),
                initState: (_) {},
                builder: (_) {
                  final currentTheme = _.theme.value;
                  return ToggleButton(
                    onDarkModeSelected: () {
                      _.setTheme('dark');
                    },
                    onLightModeSelected: () {
                      _.setTheme('light');
                    },
                    currentTheme: currentTheme,
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
