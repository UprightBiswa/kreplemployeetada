import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/user_details_model.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/components/tour_save_sheet.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class AttendanceViewPage extends StatefulWidget {
  final UserDetails userDetails;
  const AttendanceViewPage({
    super.key,
    required this.userDetails,
  });

  @override
  State<AttendanceViewPage> createState() => _AttendanceViewPageState();
}

class _AttendanceViewPageState extends State<AttendanceViewPage> {
  late String _month;

  @override
  void initState() {
    super.initState();
    _month = DateFormat('MMMM').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Attendance',
          style: AppTypography.kMedium15,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.twentyHorizontal),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20.h),
              child: CustomHeaderText(
                text: "My Attendance",
                fontColor:
                    isDarkMode(context) ? AppColors.kWhite : Colors.black,
                fontSize: MediaQuery.of(context).size.width / 18,
              ),
            ),
            SizedBox(height: 20.h),
            PrimaryContainer(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome, ${widget.userDetails.employeeName} 👋',
                        style: AppTypography.kMedium14
                            .copyWith(color: AppColors.kGrey)),
                    SizedBox(height: 4.h),
                    Text("Today's Status",
                        style: AppTypography.kBold20
                            .copyWith(fontFamily: 'NexaBold')),
                    SizedBox(height: 8.h),
                    RichText(
                      text: TextSpan(
                        text: DateTime.now().day.toString(),
                        style: AppTypography.kBold24.copyWith(
                            color: AppColors.kAccent1, fontFamily: 'NexaBold'),
                        children: [
                          TextSpan(
                            text:
                                DateFormat(' MMMM yyyy').format(DateTime.now()),
                            style: AppTypography.kBold16.copyWith(
                                color: isDarkMode(context)
                                    ? AppColors.kWhite
                                    : AppColors.kGrey,
                                fontFamily: 'NexaBold'),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            DateFormat('hh:mm:ss a').format(DateTime.now()),
                            style: AppTypography.kLight14.copyWith(
                                color: isDarkMode(context)
                                    ? AppColors.kWhite
                                    : AppColors.kGrey,
                                fontFamily: 'NexaBold'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.h),
              child: Row(
                children: [
                  CustomHeaderText(
                    text: _month,
                    fontSize: 18.sp,
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Pick a Month',
                    icon: AppAssets.kArrowForward,
                    isBorder: true,
                    onTap: () async {
                      final DateTime? picked = await showMonthPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2099),
                      );

                      if (picked != null) {
                        setState(() {
                          _month = DateFormat('MMMM').format(picked);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true, // Added this line
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      top: index > 0 ? 12 : 0, left: 6, right: 6),
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(),
                          decoration: const BoxDecoration(
                            color: Colors.blue, // Change color as needed
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "EE\ndd",
                              style: TextStyle(
                                fontFamily: "NexaBold",
                                fontSize: 14.h,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Check In",
                              style: TextStyle(
                                fontFamily: "NexaRegular",
                                fontSize: 14.h,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              "09:00 AM", // Replace with your data
                              style: TextStyle(
                                fontFamily: "NexaBold",
                                fontSize: 12.h,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Check Out",
                              style: TextStyle(
                                fontFamily: "NexaRegular",
                                fontSize: 14.h,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              "06:00 PM", // Replace with your data
                              style: TextStyle(
                                fontFamily: "NexaBold",
                                fontSize: 10.h,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomSheet: SaveTourSheet(
        bookText: 'Check In',
        draftText: 'Check Out',
        saveCallback: () {
          // saveTour();
        },
        draftCallback: () {
          //  saveAsDraft();
        },
      ),
    );
  }
}
