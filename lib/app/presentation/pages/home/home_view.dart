import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/pages_model.dart';
import 'package:kreplemployee/app/data/model/user_details_model.dart';
import 'package:kreplemployee/app/data/repository/auth/auth_token.dart';
import 'package:kreplemployee/app/logic/provider/loginProvider/login_provider.dart';
import 'package:kreplemployee/app/presentation/pages/attendance/attendance_view_page.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/attendance_card.dart';
import 'package:kreplemployee/app/presentation/pages/menus/all_menus_view.dart';
import 'package:kreplemployee/app/presentation/pages/menus/components/pages_card.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/new_products_list.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  final UserDetails userDetails;
  const HomeView({
    super.key,
    required this.userDetails,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late LoginProvider loginProvider;
  final AuthState authState = AuthState();
  late String? username;
  UserDetails? userDetails;

  @override
  void initState() {
    super.initState();
    userDetails = widget.userDetails;
    getUsername();
  }

  Future<void> getUsername() async {
    username = await authState.getUserCode();
    if (username != null) {
      // ignore: use_build_context_synchronously
      loginProvider = Provider.of<LoginProvider>(context, listen: false);
      await userInfoRequest();
    }
  }

  Future<void> userInfoRequest() async {
    try {
      await loginProvider.getUserInfo(username!, context);
      if (loginProvider.userDetailsResponse != null &&
          loginProvider.userDetailsResponse!.success &&
          loginProvider.userDetails != null) {
        setState(() {
          userDetails = loginProvider.userDetails!;
        });
      } else {
        final errorMessage = loginProvider.userDetailsResponse != null
            ? loginProvider.userDetailsResponse!.message
            : 'Failed to fetch user info';
        throw errorMessage;
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching user info $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            PrimaryContainer(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Welcome, ${userDetails?.employeeName ?? 'Krepl Employee'} 👋',
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
            SizedBox(height: 16.h),
            const NewProductList(),
            SizedBox(height: 16.h),
            PrimaryContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  if (index == 3) {
                    return CategorySeeAllButton(onTap: () {
                      Get.to(() => const AllPages());
                    });
                  } else {
                    return PagesCard(
                      category: categories[index],
                    );
                  }
                }),
              ),
            ),
            SizedBox(height: 16.h),
            PrimaryContainer(
              child: AttendanceCard(
                itemColor: isDarkMode(context)
                    ? AppColors.kSecondary
                    : const Color(0xFFEAF6EF),
                icon: Icons.check,
                title: "Check In",
                subtitle: "Tap to view Attendance",
                onTap: () {
                  Get.to(() => AttendanceViewPage(
                        userDetails: userDetails!,
                      ));
                },
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
