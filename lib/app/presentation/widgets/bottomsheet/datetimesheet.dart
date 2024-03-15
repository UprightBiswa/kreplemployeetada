import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/helper/datetimeformat/datetime_format.dart';
import 'package:kreplemployee/app/data/helper/keys/date_time_format.dart';
import 'package:kreplemployee/app/presentation/pages/categories/components/custom_calendar_card.dart';
import 'package:kreplemployee/app/presentation/pages/categories/components/date_card.dart';
import 'package:kreplemployee/app/presentation/pages/categories/components/time_select_card.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_icon_button.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class DateTimeSheet extends StatefulWidget {
  final DateTime initialDate;
  final DateTime initialTime;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<DateTime> onTimeSelected;

  const DateTimeSheet({
    Key? key,
    required this.initialDate,
    required this.initialTime,
    required this.onDateSelected,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  State<DateTimeSheet> createState() => _DateTimeSheetState();
}

class _DateTimeSheetState extends State<DateTimeSheet> {
  late DateTime _selectedTime;
  late DateTime _selectedDay;
  bool isDate = false;
  bool isTime = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDate;
    _selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceOut,
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: isDarkMode(context) ? AppColors.kContentColor : AppColors.kWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CustomHeaderText(
                text: 'Select your Date & Time?',
                fontSize: 18.sp,
              ),
              const Spacer(),
              CustomIconButton(
                onTap: () {
                  Get.back();
                },
                isCircle: true,
                isEnabled: false,
                icon: AppAssets.kCross,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          DateCard(
            onTap: () {
              setState(() {
                isDate = !isDate;
                isTime = false;
              });
            },
            title: 'Date',
            subtitle: _selectedDay == null
                ? 'Select your Date'
                : DateFormat('dd MMMM, yyyy').format(_selectedDay),
            icon: AppAssets.kDate,
            color: const Color(0xFFFFBC99),
          ),
          SizedBox(height: 16.h),
          AnimatedCrossFade(
            firstChild: SizedBox(
              height: 350.h,
              child: CustomCalendarCard(
                onDaySelected: (day) {
                  setState(() {
                    _selectedDay = day!;
                    isDate = false;
                  });
                  widget.onDateSelected(day!);
                },
              ),
            ),
            secondChild: const SizedBox(),
            crossFadeState:
                isDate ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500),
          ),
          DateCard(
            onTap: () {
              setState(() {
                isTime = !isTime;
                isDate = false;
              });
            },
            title: 'Time',
            subtitle: _selectedTime != null
                ? '${DateTimeFormatHelper.formatTime(_selectedTime)} - ${DateTimeFormatHelper.formatTime(_selectedTime.add(const Duration(hours: 1)))}'
                : 'Select your Time',
            icon: AppAssets.kTime,
            color: AppColors.kLime,
          ),
          isTime ? SizedBox(height: 20.h) : const SizedBox(),
          AnimatedCrossFade(
            firstChild: TimeSelectCard(
              onTimeSelected: (time) {
                setState(() {
                  _selectedTime = time;
                  isTime = false;
                });
                widget.onTimeSelected(time);
              },
            ),
            secondChild: const SizedBox(),
            crossFadeState:
                isTime ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 500),
          ),
          SizedBox(height: 20.h),
          PrimaryButton(
            onTap: () {
              Get.back();
            },
            text: 'Continue',
            color: _selectedDay != null && _selectedTime != null
                ? null
                : isDarkMode(context)
                    ? AppColors.kDarkInput
                    : AppColors.kInput,
          ),
        ],
      ),
    );
  }
}
