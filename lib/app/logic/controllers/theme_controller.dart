import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kreplemployee/app/data/helper/keys/local_storage.dart';

class ThemeController extends GetxController with WidgetsBindingObserver {
  final storage = GetStorage();
  RxString theme = RxString(ThemeOptions.system);
  Rx<ThemeMode> themeMode = Rx<ThemeMode>(ThemeMode.light);

  @override
  void onInit() {
    super.onInit();
    getThemeState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    updateThemeMode();
  }

  Future<void> getThemeState() async {
    final String? themeInStorage = storage.read(LocalStorageKeys.theme);
    if (themeInStorage != null) {
      return setTheme(themeInStorage);
    } else {
      return setTheme(ThemeOptions.light);
    }
  }

  Future<void> setTheme(String value) async {
    theme.value = value;
    await storage.write(LocalStorageKeys.theme, value);
    updateThemeMode();
    update();
  }

  void updateThemeMode() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    //final brightness = MediaQuery.of(Get.context!).platformBrightness;
    final systemThemeMode =
        brightness == Brightness.dark ? ThemeOptions.dark : ThemeOptions.light;

    if (theme.value == ThemeOptions.system) {
      if (systemThemeMode == ThemeOptions.dark) {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }
    } else {
      if (theme.value == ThemeOptions.dark) {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }
    }
  }
}

class ThemeOptions {
  static const String system = 'system';
  static const String light = 'light';
  static const String dark = 'dark';
}
