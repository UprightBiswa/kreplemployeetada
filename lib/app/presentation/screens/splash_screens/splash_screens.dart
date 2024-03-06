import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/repository/auth/auth_token.dart';
import 'package:kreplemployee/app/presentation/pages/landing_pages/landing_pages.dart';
import 'package:kreplemployee/app/presentation/screens/auth/sign_in.dart';
import 'package:kreplemployee/app/presentation/screens/language_screens/language_chose.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

void showToast(String message, BuildContext context) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  // final AppInfoProvider _newAppinfoProvider = AppInfoProvider();
  String appVersion = "";
  @override
  void initState() {
    super.initState();
    getAppVersion();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _logoAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward().whenComplete(
      () async {
        bool isFirstLaunch = await checkFirstLaunch();
        if (isFirstLaunch) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LanguageScreen()),
          );
        } else {
          navigateBasedOnLoginStatus();
          // fetchAppInfo();
        }
      },
    );
  }

  Future<void> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          appVersion = packageInfo.version;
        });
      }
      print('app version: $appVersion');
    } catch (e) {
      print('Error getting app version: $e');
      setState(() {
        appVersion = '';
      });
    }
  }

  // void fetchAppInfo() async {
  //   try {
  //     final response = await _newAppinfoProvider.getappinfo(context: context);

  //     if (response.success) {
  //       final appInfo = response.data?.first;

  //       // Check if app needs update
  //       if (appInfo != null && appInfo.appVersion != appVersion) {
  //         showUpgradeDialog(appInfo.appLink, appInfo.priority);
  //       } else {
  //         navigateBasedOnLoginStatus();
  //       }
  //     } else {
  //       // Handle error state if the API response is not successful
  //       // For example, show a toast message or an error dialog
  //       showToast('Failed to fetch app info', context);
  //     }
  //   } catch (e) {
  //     // Handle error if something goes wrong with fetching app info
  //     // For example, show a toast message or an error dialog
  //     if (e.toString().contains('No internet connection')) {
  //       showNoInternetDialog();
  //     } else {
  //       showToast('Error fetching app info: $e', context);
  //     }
  //     print('Exception fetching: $e');
  //   }
  // }

  // void showUpgradeDialog(String appLink, String priority) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return PlaceholderDialog(
  //         image: Image.asset(
  //           'assets/images/logo.png',
  //           width: 80,
  //           height: 80,
  //         ),
  //         title: 'Upgrade Required',
  //         message: 'A new version of the app is available.',
  //         actions: [
  //           TextButton(
  //             onPressed: () async {
  //               if (await canLaunchUrl(Uri.parse(appLink))) {
  //                 await launchUrl(Uri.parse(appLink));
  //               } else {
  //                 await launchUrl(Uri.parse(appLink));
  //                 print('Could not launch $appLink');
  //               }
  //             },
  //             child: const Text('Upgrade Now'),
  //           ),
  //           // Cancel Button (if priority is '0')
  //           if (priority == '0')
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 // Handle cancellation action if needed
  //                 navigateBasedOnLoginStatus();
  //               },
  //               child: const Text('Cancel'),
  //             ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.red),
              SizedBox(width: 10),
              Text(
                'No Internet Connection',
                style: TextStyle(
                    color: AppColors.kAccent7,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
              'Please turn on your internet connection to continue.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Reload'),
              onPressed: () {
                Navigator.of(context).pop();
                //fetchAppInfo();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateBasedOnLoginStatus() async {
    bool isLoggedIn =
        (await Provider.of<AuthState>(context, listen: false).getToken())
                ?.isNotEmpty ??
            false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }
  }

  Future<bool> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
    if (isFirstLaunch) {
      prefs.setBool('firstLaunch', false);
    }
    return isFirstLaunch;
  }

  @override
  void dispose() {
    // Restore the system overlays when the screen is disposed
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.dispose();
    super.dispose();
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kWhite,
      appBar: AppBar(
        backgroundColor:
            isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kWhite,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Your company logo image goes here
                      Transform.translate(
                        offset: Offset(0, _logoAnimation.value),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 180,
                          height: 180,
                        ),
                      ),
                      const SizedBox(height: 200),
                      // const Text(
                      //   'Krishaj Sarthi',
                      //   style: TextStyle(
                      //       color: AppColors.kPrimary,
                      //       fontSize: 24,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 200),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height *
                    0.4, // 60% of the screen height
                decoration: const BoxDecoration(
                  color: Colors.transparent, // Transparent background
                ),
                child: Lottie.asset(
                  'assets/annimations/splash.json',
                  width: double.infinity, // Cover full screen width
                  height: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode(context)
              ? AppColors.kDarkBackground
              : AppColors.kWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Powered by:', style: AppTypography.kMedium14),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/indigi.png',
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
