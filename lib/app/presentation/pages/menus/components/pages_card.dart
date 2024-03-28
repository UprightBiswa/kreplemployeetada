import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/data/model/pages_model.dart';
import 'package:kreplemployee/app/presentation/screens/ageing_report_bill_wise_screens/AgeingReportBillWisePage.dart';
import 'package:kreplemployee/app/presentation/screens/ageing_report_bill_wise_screens/AgeingSlabWithPaymentTermPage.dart';
import 'package:kreplemployee/app/presentation/screens/ageing_report_bill_wise_screens/AgeingSlabWithoutPaymentTermPage.dart';

import 'package:kreplemployee/app/presentation/screens/cart_screens/CartPage.dart';
import 'package:kreplemployee/app/presentation/screens/collection_report_screens/CollectionReportPage.dart';
import 'package:kreplemployee/app/presentation/screens/ledger_screens/ledgerPage.dart';
import 'package:kreplemployee/app/presentation/screens/order_dspatch_status_screens/OrderDispatchStatusPage.dart';
import 'package:kreplemployee/app/presentation/screens/order_screens/order_page.dart';
import 'package:kreplemployee/app/presentation/screens/sales_analysis_screens/SalesAnalysisPage.dart';
import 'package:kreplemployee/app/presentation/screens/submitted_order_screens/submitted_order_page.dart';
import 'package:kreplemployee/app/presentation/screens/tourplan/tourplanpage.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/button_animation.dart';

class PagesCard extends StatelessWidget {
  final CategoryModel category;
  final bool isGridView;
  const PagesCard({
    required this.category,
    this.isGridView = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonAnimation(
      onTap: () {
        switch (category.id) {
          case '1':
            Get.to(() => const TourPlanPage());
            break;
          case '2':
            Get.to(() => const OrderPage());
            break;
          case '3':
            Get.to(() => const CartPage());
            break;
          case '4':
            Get.to(() => const SubmittedOrderPage());
            break;
          case '5':
            Get.to(() => const OrderDispatchStatusPage());
            break;
          case '6':
            Get.to(() => const SalesAnalysisPage());
            break;
          case '7':
            Get.to(() => const LedgerPage());
            break;
          case '8':
            Get.to(() => const CollectionReportPage());
            break;
          case '9':
            Get.to(() => const AgeingReportBillWisePage());
            break;
          case '10':
            Get.to(() => const AgeingSlabWithoutPaymentTermPage());
            break;
          case '11':
            Get.to(() => const AgeingSlabWithPaymentTermPage());
            break;
        }
      },
      child: Column(
        children: [
          Container(
            height: isGridView ? 72.h : 58.h,
            width: isGridView ? 72.h : 58.h,
            alignment: Alignment.center,
            padding: EdgeInsets.all(18.h),
            decoration: BoxDecoration(
              color: category.color,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(category.image),
          ),
          SizedBox(height: 12.h),
          Text(
            category.name,
            style: AppTypography.kLight13,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CategorySeeAllButton extends StatelessWidget {
  final VoidCallback onTap;
  const CategorySeeAllButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return ButtonAnimation(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 58.h,
            width: 58.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDarkMode(context)
                  ? AppColors.kContentColor
                  : const Color(0xFFECECEC),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_forward),
          ),
          SizedBox(height: 12.h),
          Text('See All', style: AppTypography.kLight13),
        ],
      ),
    );
  }
}
