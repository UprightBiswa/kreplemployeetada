import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';

class SaveTourSheet extends StatelessWidget {
  final VoidCallback? saveCallback;
  final VoidCallback? bookCallback;
  final String bookText;
  const SaveTourSheet({
    super.key,
    this.saveCallback,
    this.bookCallback,
    required this.bookText,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDarkMode(context) ? Colors.black : AppColors.kWhite,
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onTap: saveCallback!,
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
                  onTap: bookCallback!,
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
