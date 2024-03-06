import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/profile/profile_view.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLeadingPressed;
  const HomeAppBar({
    super.key,
    required this.title,
    this.onLeadingPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      leading: IconButton(
        onPressed: onLeadingPressed,
        icon: SvgPicture.asset(
          AppAssets.kMenu,
          colorFilter: ColorFilter.mode(
              isDarkMode(context) ? AppColors.kWhite : Colors.black,
              BlendMode.srcIn),
        ),
      ),
      title: Text(
        title,
        style: AppTypography.kMedium15.copyWith(color: AppColors.kGrey),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.to(() => const ProfileView());
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Profile',
                      style: AppTypography.kMedium10
                          .copyWith(color: AppColors.kWarning)),
                  Text('Krepl Employee',
                      style: AppTypography.kLight8
                          .copyWith(color: AppColors.kGrey))
                ],
              ),
              SizedBox(width: 5.w),
              SvgPicture.asset(
                AppAssets.kFriends,
                colorFilter:
                    const ColorFilter.mode(AppColors.kWarning, BlendMode.srcIn),
              )
            ],
          ),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}
