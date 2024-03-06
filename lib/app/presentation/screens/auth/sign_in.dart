import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/landing_pages/landing_pages.dart';
import 'package:kreplemployee/app/presentation/screens/auth/components/auth_field.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/shake_animation.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_social_button.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/app/presentation/widgets/dividers/custom_vertical_divider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

String getEmojiFlag(String emojiString) {
  const flagOffset = 0x1F1E6;
  const asciiOffset = 0x41;
  final firstChar = emojiString.codeUnitAt(0) - asciiOffset + flagOffset;
  final secondChar = emojiString.codeUnitAt(1) - asciiOffset + flagOffset;
  return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
}

class _SignInState extends State<SignIn> {
  final TextEditingController _phoneController = TextEditingController();
  bool isFormValidated = false;
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kWhite,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.twentyHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100.h),
            Center(child: Image.asset(AppAssets.kLogoBlue)),
            SizedBox(height: 62.h),
            Text('Sign in', style: AppTypography.kMedium32),
            SizedBox(height: 24.h),
            Text('Phone Number', style: AppTypography.kMedium15),
            SizedBox(height: 8.h),
            // Number Field.
            Container(
              decoration: BoxDecoration(
                  color: isDarkMode(context)
                      ? AppColors.kContentColor
                      : AppColors.kInput,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
              child: Row(
                children: [
                  SizedBox(
                    width: 90.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getEmojiFlag(
                              'IN'), // Assuming 'IN' is the country code for India
                          style: const TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '+91', // Static dial code for India
                          style: AppTypography.kMedium14,
                        )
                      ],
                    ),
                  ),
                  const CustomVerticalDivider(),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: AuthField(
                      controller: _phoneController,
                      onChanged: (value) {
                        if (value!.isNotEmpty) {
                          setState(() {});
                          isFormValidated = true;
                          return value;
                        } else {
                          setState(() {});
                          isFormValidated = false;
                          return value;
                        }
                      },
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.number,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(RegExp(r'^0[0-9]*$'))
                      ],
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ShakeWidget(
              key: _shakeKey,
              shakeOffset: 10.0,
              shakeDuration: const Duration(milliseconds: 500),
              child: PrimaryButton(
                onTap: () {
                  if (isFormValidated) {
                    Get.offAll(() => const LandingPage());
                  } else {
                    _shakeKey.currentState?.shake();
                  }
                },
                text: 'Sign in',
                color: isFormValidated
                    ? null
                    : isDarkMode(context)
                        ? AppColors.kDarkHint
                        : AppColors.kInput,
              ),
            ),
            SizedBox(height: 63.h),
            Center(child: Text('Sign in with', style: AppTypography.kMedium14)),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSocialButton(onTap: () {}, icon: AppAssets.kGoogle),
                SizedBox(width: 35.w),
                CustomSocialButton(onTap: () {}, icon: AppAssets.kFacebook),
                SizedBox(width: 35.w),
                CustomSocialButton(onTap: () {}, icon: AppAssets.kApple),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
