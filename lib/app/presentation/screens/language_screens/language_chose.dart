import 'package:flutter/material.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/repository/auth/auth_token.dart';
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
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<Language> languageList = Language.languageList();
  Language? selectedLanguage;

  void navigateToOnboarding() async {
    if (selectedLanguage == null) {
      // Show a snackbar if no language is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a language."),
        ),
      );
      return;
    }

    // Set the app's locale based on the selected language
    Locale locale = await setLocale(selectedLanguage!.languageCode);
    MyApp.setLocale(context, locale);

    // Check if it's the first-time installation
    bool isFirstInstallation = await checkFirstInstallation();
    // Check if the user is logged in
    bool isLoggedIn = await Provider.of<AuthState>(context, listen: false).getToken() != null;

    if (isFirstInstallation) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const LandingPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      }
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
                                        // Debug print statements
                                        print(
                                            'Selected language changed to: ${selectedLanguage?.name}');
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
