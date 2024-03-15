import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';

class SaveTourSheet extends StatelessWidget {
  final VoidCallback? saveCallback;
  final VoidCallback? draftCallback;
  final String bookText;
  const SaveTourSheet({
    super.key,
    this.saveCallback,
    this.draftCallback,
    required this.bookText,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDarkMode(context) ? Colors.black : AppColors.kWhite,
      padding:
          EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onTap: draftCallback!,
                  text: 'Save Draft',
                  color: isDarkMode(context)
                      ? AppColors.kContentColor
                      : AppColors.kWhite,
                  isBorder: true,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: PrimaryButton(
                  onTap: saveCallback!,
                  text: bookText,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
