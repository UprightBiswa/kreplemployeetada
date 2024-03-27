import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/support/components/support_card.dart';
import 'package:kreplemployee/app/presentation/pages/support/live_chat_view.dart';
import 'package:kreplemployee/app/presentation/widgets/drawer/custom_drawer.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support',
          style: AppTypography.kMedium15.copyWith(color: AppColors.kGrey),
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const CustomHeaderText(text: 'Support'),
            SizedBox(height: 20.h),
            SupportCard(
                onTap: () {
                  Get.to(() => const LiveChatView());
                },
                image: AppAssets.kLogo,
                title: 'Live Chat',
                subtitle: 'Chat time 9am- 9pm'),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
