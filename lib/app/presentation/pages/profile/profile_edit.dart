import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/user_details_model.dart';
import 'package:kreplemployee/app/presentation/screens/auth/components/auth_field.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class ProfileEdit extends StatefulWidget {
  final UserDetails? userDetails;
  const ProfileEdit({
    super.key,
    this.userDetails,
  });

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void initState() {
    _phoneController.text = '1234567898';
    _emailController.text = 'johndoe@gmail.com';
    _genderController.text = 'Male';
    _dobController.text = '06/11/1998';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.twentyHorizontal),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const CustomHeaderText(text: 'Edit Profile'),
            SizedBox(height: 21.h),
            PrimaryContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Phone Number', style: AppTypography.kMedium15),
                SizedBox(height: 8.h),
                // Number Field.
                Container(
                  decoration: BoxDecoration(
                      color: isDarkMode(context)
                          ? AppColors.kContentColor
                          : AppColors.kInput,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusTen)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: AuthField(
                          controller: _phoneController,
                          hintText: 'Phone Number',
                          keyboardType: TextInputType.number,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny(
                                RegExp(r'^0[0-9]*$'))
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Text('Email', style: AppTypography.kMedium15),
                SizedBox(height: 8.h),
                AuthField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24.h),
                Text('Gender', style: AppTypography.kMedium15),
                SizedBox(height: 8.h),
                AuthField(
                  controller: _genderController,
                  hintText: 'Gender',
                ),
                SizedBox(height: 24.h),
                Text('Date of Birth', style: AppTypography.kMedium15),
                SizedBox(height: 8.h),
                AuthField(
                  controller: _dobController,
                  hintText: '06/11/1998',
                  keyboardType: TextInputType.datetime,
                ),
              ],
            )),
            SizedBox(height: 250.h),
          ],
        ),
      ),
    );
  }
}
