import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/repository/auth/auth_token.dart';
import 'package:kreplemployee/app/presentation/pages/profile/profile_view.dart';
import 'package:kreplemployee/app/presentation/pages/setting/app_version.dart';
import 'package:kreplemployee/app/presentation/pages/setting/setting_banner.dart';
import 'package:kreplemployee/app/presentation/pages/support/support_view.dart';
import 'package:kreplemployee/app/presentation/screens/auth/sign_in.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/classes/language.dart';
import 'package:kreplemployee/classes/language_constrants.dart';
import 'package:kreplemployee/main.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Language? selectedLanguage;
  String selectedLanguageCode = "";
  String appVersion = "";
  bool loading = true;
  String appName = '';
  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _getAppName();
  }

  Future<void> _getAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadInitialData() async {
    try {
      if (mounted) {
        await Future.wait([
          _loadSelectedLanguage(),
          getAppVersion(),
        ]);
        setState(() {
          loading = false;
        });
      }
    } catch (error) {
      // Handle errors appropriately
      // ...
    }
  }

  Future<void> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          appVersion = packageInfo.version;
        });
      }
    } catch (e) {
      setState(() {
        appVersion = 'Unknown';
      });
    }
  }

  Future<void> _logout() async {
    bool confirmLogout = await _showLogoutConfirmationDialog();
    if (confirmLogout) {
      AuthState().clearToken();

      Get.offAll(() => const SignIn());
    }
  }

  Future<bool> _showLogoutConfirmationDialog() async {
    bool? result = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning,
                size: 48,
                color: Colors.orange,
              ),
              SizedBox(height: 16.h),
              Text(
                translation(context).confirm_logout,
                style: AppTypography.kBold24.copyWith(
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                translation(context).do_you_really_want_to_log_out,
                textAlign: TextAlign.center,
                style: AppTypography.kMedium12.copyWith(
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      onTap: () => Navigator.of(context).pop(false),
                      text: translation(context).no,
                      isBorder: true,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: PrimaryButton(
                      onTap: () => Navigator.of(context).pop(true),
                      text: translation(context).yes,
                      isBorder: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return result ?? false;
  }

  Future<void> _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedLanguageCode = prefs.getString(LAGUAGE_CODE) ?? ENGLISH;

    if (!Language.languageList()
        .any((lang) => lang.languageCode == selectedLanguageCode)) {
      selectedLanguageCode = ENGLISH;
    }

    setState(() {
      selectedLanguage = Language.languageList().firstWhere(
        (lang) => lang.languageCode == selectedLanguageCode,
        orElse: () => Language(2, "English", "en"),
      );
    });

    // ignore: use_build_context_synchronously
    MyApp.setLocale(context, Locale(selectedLanguageCode));
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            ListTile(
              title: Text(
                '${translation(context).please_select_your_language}: ${selectedLanguage?.name ?? ''}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            ...Language.languageList()
                .map((e) => Column(
                      children: [
                        RadioListTile<Language>(
                          title: Text(e.name),
                          groupValue: selectedLanguage,
                          value: e,
                          onChanged: (Language? value) async {
                            setState(() {
                              selectedLanguage = value;
                            });

                            // Debug print statements
                            if (kDebugMode) {
                              print(
                                  'Selected language changed to: ${selectedLanguage?.name}');
                            }

                            await setLocale(e.languageCode);

                            // ignore: use_build_context_synchronously
                            MyApp.setLocale(context, Locale(e.languageCode));

                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                          selected: selectedLanguage == e,
                        ),
                        const Divider(),
                      ],
                    ))
                .toList(),
          ],
        );
      },
    );
  }

  void launchurlprivacypolicy(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      await launchUrl(Uri.parse(url));
    }
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSettingsPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTypography.kMedium15,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            UserCard(
              backgroundColor: Colors.green,
              userName: appName,
              userProfilePic: AssetImage(
                AppAssets.kLogo,
              ),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.yellow[600],
                ),
                title: "Profile",
                subtitle: "Tap to view your profile",
                onTap: () {
                  Get.to(() => const ProfileView());
                },
              ),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    showLanguageBottomSheet(context);
                  },
                  icons: Icons.language,
                  iconStyle: IconStyle(),
                  title: 'Change Language',
                  subtitle: selectedLanguage?.name ?? '',
                ),
              ],
            ),

            SettingsGroup(
              settingsGroupTitle: "Support",
              items: [
                SettingsItem(
                  onTap: () {
                    Get.to(() => const SupportView());
                  },
                  icons: Icons.help,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.orange,
                  ),
                  title: 'Help',
                ),
                SettingsItem(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => VideoTutorialScreen(),
                    //   ),
                    // );
                  },
                  icons: Icons.video_library,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.red,
                  ),
                  title: 'You Tube Video',
                ),
                SettingsItem(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => FeedbackScreen(),
                    //   ),
                    // );
                  },
                  icons: Icons.feedback,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.blueGrey,
                  ),
                  title: 'Feedback',
                ),
                SettingsItem(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ComplaintScreen(),
                    //   ),
                    // );
                  },
                  icons: Icons.report_problem,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.green,
                  ),
                  title: 'Complaint',
                ),
                SettingsItem(
                  onTap: () {
                    Get.to(() => const SupportView());
                  },
                  icons: Icons.support,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.brown,
                  ),
                  title: 'Support',
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    _logout();
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {
                    launchurlprivacypolicy(
                        'https://krepl.indigidigital.in/krepl_privacy_policy.html');
                  },
                  icons: Icons.privacy_tip,
                  title: "Privacy Policy",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.file_copy,
                  title: "Terms & Conditions",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info,
                  title: "App Version",
                  subtitle: appVersion,
                  trailing: const AppVersionWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading ? _buildLoadingIndicator() : _buildSettingsPage();
  }
}
