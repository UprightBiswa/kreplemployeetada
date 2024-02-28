
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/presentation/screens/splash_screens/splash_screens.dart';

class AppRoutes {
  static String onboarding = '/';

  static List<GetPage> routes = [
    GetPage<Route<dynamic>>(
      name: onboarding,
      page: () => const SplashScreen(),
    ),
  ];

  static String getOnboardingRoute() => onboarding;

}
