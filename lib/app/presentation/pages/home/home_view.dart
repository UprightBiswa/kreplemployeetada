import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/pages_model.dart';
import 'package:kreplemployee/app/data/model/user_details_model.dart';
import 'package:kreplemployee/app/data/repository/auth/auth_token.dart';
import 'package:kreplemployee/app/logic/provider/loginProvider/login_provider.dart';
import 'package:kreplemployee/app/presentation/pages/menus/all_menus_view.dart';
import 'package:kreplemployee/app/presentation/pages/menus/components/pages_card.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/new_products_list.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

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
    getUsername();
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
  }

  Future<void> getUsername() async {
    username = await authState.getUserCode();
    if (username != null) {
      await userInfoRequest();
    }
  }

  Future<void> userInfoRequest() async {
    try {
      await loginProvider.getUserInfo(username!, context);
      if (loginProvider.userDetailsResponse != null &&
          loginProvider.userDetailsResponse!.success) {
        setState(() {
          userDetails = loginProvider.userDetailsResponse!.data;
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
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            PrimaryContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Hello ${userDetails?.employeeName ?? 'Krepl Employee'} 👋',
                      style: AppTypography.kMedium14
                          .copyWith(color: AppColors.kGrey)),
                  SizedBox(height: 4.h),
                  Text('What you are looking for today',
                      style: AppTypography.kBold32),
                ],
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
          ],
        ),
      ),
    );
  }
}
