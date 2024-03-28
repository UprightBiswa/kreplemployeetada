import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/user_details_model.dart';
import 'package:kreplemployee/app/data/repository/auth/auth_token.dart';
import 'package:kreplemployee/app/logic/provider/loginProvider/login_provider.dart';
import 'package:kreplemployee/app/presentation/pages/landing_pages/landing_pages.dart';
import 'package:kreplemployee/app/presentation/screens/auth/sign_in.dart';
import 'package:kreplemployee/app/presentation/screens/onboarding_screens/onboarding_screen.dart';
import 'package:kreplemployee/classes/language.dart';
import 'package:kreplemployee/classes/language_constrants.dart';
import 'package:kreplemployee/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<Language> languageList = Language.languageList();
  Language? selectedLanguage;
  late LoginProvider loginProvider;
  

  @override
  void initState() {
    super.initState();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
  }

  void navigateToOnboarding() async {
    if (selectedLanguage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a language."),
        ),
      );
      return;
    }

    Locale locale = await setLocale(selectedLanguage!.languageCode);
    MyApp.setLocale(context, locale);

    bool isFirstInstallation = await checkFirstInstallation();

    if (isFirstInstallation) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else {
      String? userCode = await AuthState().getUserCode();
      if (userCode != null && userCode.isNotEmpty) {
        UserDetails? userDetails = await fetchUserDetails(userCode);
        if (userDetails != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LandingPage(userDetails: userDetails),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      }
    }
  }

  Future<UserDetails?> fetchUserDetails(String userCode) async {
    try {
      await loginProvider.getUserInfo(userCode, context);
      return loginProvider.userDetails;
    } catch (e) {
      
      if (kDebugMode) {
        print('Error fetching user details: $e');
      }
      return null;
    }
  }

  Future<bool> checkFirstInstallation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstInstallation = prefs.getBool('firstInstallation') ?? true;
    if (isFirstInstallation) {
      prefs.setBool('firstInstallation', false);
    }
    return isFirstInstallation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kBackground,
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Choose your preferred language:',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Radio buttons to select the language

                          ...languageList
                              .map(
                                (language) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: ListTile(
                                    title: Text(
                                      language.name,
                                      style: TextStyle(
                                        color: selectedLanguage == language
                                            ? AppColors.kPrimary
                                            : Colors.black,
                                      ),
                                    ),
                                    leading: Radio<Language>(
                                      value: language,
                                      groupValue: selectedLanguage,
                                      onChanged: (Language? value) {
                                        setState(() {
                                          selectedLanguage = value;
                                        });
                                        if (kDebugMode) {
                                          print(
                                              'Selected language changed to: ${selectedLanguage?.name}');
                                        }
                                      },
                                      activeColor: AppColors.kPrimary,
                                    ),
                                    // Add BoxDecoration to each language button
                                    tileColor: selectedLanguage == language
                                        ? AppColors.kPrimary.withOpacity(0.1)
                                        : Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: AppColors.kPrimary,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () => navigateToOnboarding(),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedLanguage != null
                              ? AppColors
                                  .kPrimary // Green when language is selected
                              : Colors.grey,
                        ),
                        child: Center(
                          child: Text(
                            selectedLanguage != null
                                ? 'SELECT LANGUAGE'
                                : 'Please select a language',
                            style: const TextStyle(
                              color: AppColors.kBackground,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
