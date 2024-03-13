import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/categories/components/date_card.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class CheckOutDateTimeCard extends StatelessWidget {
  const CheckOutDateTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
        child: Column(
      children: [
        Row(
          children: [
            CustomHeaderText(text: 'Date & Time', fontSize: 18.sp),
            const Spacer(),
            CustomButton(
              text: 'Change',
              icon: AppAssets.kEdit,
              onTap: () {},
              isBorder: true,
            )
          ],
        ),
        SizedBox(height: 16.h),
        DateCard(
          onTap: null,
          icon: AppAssets.kDate,
          color: null,
          title: 'Date',
          subtitle: 'November 7, 2021',
        ),
        SizedBox(height: 10.h),
        DateCard(
          onTap: null,
          icon: AppAssets.kTime,
          color: null,
          title: 'Time',
          subtitle: '12:00-01:00PM',
        )
      ],
    ));
  }
}
