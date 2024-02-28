import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/logic/controllers/theme_controller.dart';
import 'package:kreplemployee/app/logic/services/theme_services.dart';
import 'package:kreplemployee/app/routes/app_routes.dart';
import 'package:kreplemployee/classes/language_constrants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app/data/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(defaultOverlay);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  // This widget is the root of your application.
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    // print(themeController.theme);
    print(themeController.theme.value); 
    return ScreenUtilInit(
      designSize: const Size(375, 844),
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            title: 'kreplemployee',
            scrollBehavior: const ScrollBehavior()
                .copyWith(physics: const BouncingScrollPhysics()),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            // themeMode: getThemeMode(themeController.theme),
             themeMode: getThemeMode(themeController.theme.value),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: _locale,
            initialRoute: AppRoutes.getOnboardingRoute(),
            getPages: AppRoutes.routes,
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        );
      }
    );
  }
}
