import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/presentation/pages/address/address_view.dart';
import 'package:kreplemployee/app/presentation/pages/categories/components/service_sheet.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/add_number.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/add_promo.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/components/checkout_custom_card.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/components/checkout_date_time_card.dart';
import 'package:kreplemployee/app/presentation/pages/checkout/components/checkout_service_card.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const CheckoutServiceCard(),
            SizedBox(height: 16.h),
            const CheckOutDateTimeCard(),
            SizedBox(height: 16.h),
            CheckoutCustomCard(
                text: 'Address',
                onTap: () {
                  Get.to(() => const AddressView(isCheckOutPage: true));
                }),
            SizedBox(height: 10.h),
            CheckoutCustomCard(
                text: 'Phone Number',
                onTap: () {
                  Get.to(() => const AddPhoneNumberView());
                }),
            SizedBox(height: 10.h),
            CheckoutCustomCard(
                text: 'Promo',
                onTap: () {
                  Get.to(() => const AddPromoCode());
                }),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomSheet: ServiceSheet(
        bookText: 'Place Order',
        saveCallback: () {},
        bookCallback: () {},
      ),
    );
  }
}
