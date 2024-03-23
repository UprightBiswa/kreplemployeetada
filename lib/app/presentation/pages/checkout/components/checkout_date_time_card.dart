import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/helper/datetimeformat/datetime_format.dart';
import 'package:kreplemployee/app/presentation/pages/menus/components/date_card.dart';
import 'package:kreplemployee/app/presentation/widgets/bottomsheet/datetimesheet.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class CheckOutDateTimeCard extends StatefulWidget {


  const CheckOutDateTimeCard({
    Key? key,
  }) : super(key: key);
  @override
  State<CheckOutDateTimeCard> createState() => _CheckOutDateTimeCardState();
}

class _CheckOutDateTimeCardState extends State<CheckOutDateTimeCard> {
  late DateTime _selectedDate;
  late DateTime _selectedTime;
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    // Format date and time using helper class methods
    String formattedDate = DateTimeFormatHelper.formatDate(_selectedDate);
    String formattedTime = DateTimeFormatHelper.formatTime(_selectedTime);
    String formattedEndTime = DateTimeFormatHelper.formatTime(
        _selectedTime.add(const Duration(hours: 1)));

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
                      initialDate: _selectedDate,
                      initialTime: _selectedTime,
                      onDateSelected: (DateTime date) {
                        setState(() {
                          _selectedDate = date;
                       
                        });
                      },
                      onTimeSelected: (DateTime time) {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                    );
                  },
                );
              },
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
          subtitle: formattedDate,
        ),
        SizedBox(height: 10.h),
        DateCard(
          onTap: null,
          icon: AppAssets.kTime,
          color: null,
          title: 'Time',
          subtitle: '$formattedTime - $formattedEndTime',
        )
      ],
    ));
  }
}
