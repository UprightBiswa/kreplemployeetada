import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/user_details_model.dart';
import 'package:kreplemployee/app/presentation/pages/profile/components/profile_field.dart';
import 'package:kreplemployee/app/presentation/pages/profile/components/profile_image_card.dart';
import 'package:kreplemployee/app/presentation/pages/profile/profile_edit.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class ProfileView extends StatefulWidget {
  final UserDetails userDetails;

  const ProfileView({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
            Row(
              children: [
                const CustomHeaderText(text: 'Profile'),
                const Spacer(),
                CustomButton(
                  onTap: () {
                    Get.to(() => ProfileEdit(userDetails: widget.userDetails));
                  },
                  icon: AppAssets.kEdit,
                  text: 'Edit Profile',
                )
              ],
            ),
            SizedBox(height: 21.h),
            PrimaryContainer(
              child: ProfileImageCard(
                onTap: null,
                textColor:
                    isDarkMode(context) ? AppColors.kWhite : Colors.black,
                userDetails: widget.userDetails,
              ),
            ),
            SizedBox(height: 16.h),
            PrimaryContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileField(
                    label: 'User Type',
                    value: widget.userDetails.userType,
                    icon: Icons.code,
                  ),
                  ProfileField(
                    label: 'User Code',
                    value: widget.userDetails.userCode,
                    icon: Icons.code,
                  ),
                  ProfileField(
                    label: 'Company Code',
                    value: widget.userDetails.companyCode,
                    icon: Icons.code,
                  ),
                  ProfileField(
                    label: 'Employee Code',
                    icon: Icons.code,
                    value: widget.userDetails.employeeCode,
                  ),
                  ProfileField(
                    label: 'Employee Name',
                    icon: Icons.code,
                    value: widget.userDetails.employeeName,
                  ),
                  ProfileField(
                    label: 'Access Type',
                    icon: Icons.code,
                    value: widget.userDetails.accessType,
                  ),
                  ProfileField(
                    label: 'Valid From',
                    icon: Icons.code,
                    value: widget.userDetails.validFrom,
                  ),
                  ProfileField(
                    label: 'Valid To',
                    icon: Icons.code,
                    value: widget.userDetails.validTo,
                  ),
                  ProfileField(
                    label: 'Status',
                    icon: Icons.code,
                    value: widget.userDetails.status,
                  ),
                ],
              ),
            ),
            SizedBox(height: 250.h),
          ],
        ),
      ),
    );
  }
}
