import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/products/products_view.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/home_appbar.dart';
import 'package:kreplemployee/app/presentation/pages/home/home_view.dart';
import 'package:kreplemployee/app/presentation/pages/notifications/notification_view.dart';
import 'package:kreplemployee/app/presentation/widgets/drawer/custom_drawer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  DateTime? currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomeView(),
      const BookingsView(),
      const NotificationView(),
    ];
    List<PreferredSizeWidget> appBarList = [
      PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(
          title: 'Home',
          onLeadingPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(
          title: 'Products',
          onLeadingPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(
          title: 'Notifications',
          onLeadingPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            currentBackPressTime = DateTime.now();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press back again to exit'),
              ),
            );
            return false; // Prevent the app from exiting
          } else {
            return true; // Allow the app to exit
          }
        } else {
          setState(() {
            _currentIndex = 0;
          });
          return false; // Prevent the app from exiting
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBarList[_currentIndex],
        body: pages[_currentIndex],
        drawer: const CustomDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Home',
              tooltip: 'Home',
              icon: SvgPicture.asset(
                AppAssets.kHome,
                height: 24,
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                AppAssets.kHome,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.kPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Products',
              tooltip: 'Products',
              icon: SvgPicture.asset(
                AppAssets.kProduct,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.kNeutral04,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                AppAssets.kProduct,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.kPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Notifications',
              tooltip: 'Notifications',
              icon: SvgPicture.asset(
                AppAssets.kNotification,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.kNeutral04,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                AppAssets.kNotification,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.kPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
