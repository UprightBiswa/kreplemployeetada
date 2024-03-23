import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/helper/datetimeformat/datetime_format.dart';
import 'package:kreplemployee/app/presentation/pages/menus/components/date_card.dart';
import 'package:kreplemployee/app/presentation/widgets/bottomsheet/datetimesheet.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class DateTimeCard extends StatefulWidget {
  final Function(DateTime) onStartDateTimeChanged;
  final Function(DateTime) onStartTimeChanged;
  final Function(DateTime) onEndDateTimeChanged;
  final Function(DateTime) onEndTimeChanged;

  const DateTimeCard({
    Key? key,
    required this.onStartDateTimeChanged,
    required this.onStartTimeChanged,
    required this.onEndDateTimeChanged,
    required this.onEndTimeChanged,
  }) : super(key: key);

  @override
  State<DateTimeCard> createState() => _DateTimeCardState();
}

class _DateTimeCardState extends State<DateTimeCard> {
  late DateTime _selectedStartDate;
  late DateTime _selectedStartTime;
  late DateTime _selectedEndDate;
  late DateTime _selectedEndTime;

  @override
  void initState() {
    super.initState();
    _selectedStartDate = DateTime.now();
    _selectedEndDate = DateTime.now();
    _selectedStartTime = DateTime.now();
    _selectedEndTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    String formattedStartDate =
        DateTimeFormatHelper.formatDate(_selectedStartDate);
    String formattedStartTime =
        DateTimeFormatHelper.formatTime(_selectedStartTime);
    String formattedEndDate = DateTimeFormatHelper.formatDate(_selectedEndDate);
    String formattedEndTime = DateTimeFormatHelper.formatTime(_selectedEndTime);

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
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                builder: (context) {
                  return DateTimeSheet(
                    initialDate: _selectedStartDate,
                    initialTime: _selectedStartTime,
                    onDateSelected: (DateTime date) {
                      setState(() {
                        _selectedStartDate = date;
                        widget.onStartDateTimeChanged(date);
                      });
                    },
                    onTimeSelected: (DateTime time) {
                      setState(() {
                        _selectedStartTime = time;
                        widget.onStartTimeChanged(time);
                      });
                    },
                  );
                },
              );
            },
            icon: AppAssets.kDate,
            color: null,
            title: 'Start Date & Time',
            subtitle: '$formattedStartDate, $formattedStartTime',
          ),
          SizedBox(height: 10.h),
          DateCard(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                builder: (context) {
                  return DateTimeSheet(
                    initialDate: _selectedEndDate,
                    initialTime: _selectedEndTime,
                    onDateSelected: (DateTime date) {
                      setState(() {
                        _selectedEndDate = date;
                        widget.onEndDateTimeChanged(date);
                      });
                    },
                    onTimeSelected: (DateTime time) {
                      setState(() {
                        _selectedEndTime = time;
                        widget.onEndTimeChanged(time);
                      });
                    },
                  );
                },
              );
            },
            icon: AppAssets.kDate,
            color: null,
            title: 'End Date & Time',
            subtitle: '$formattedEndDate, $formattedEndTime',
          )
        ],
      ),
    );
  }
}
