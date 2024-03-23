import 'package:flutter/material.dart';
import 'package:kreplemployee/app/data/constants/app_assets.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  Color color;
  String pageName; // Added page name
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.color,
    required this.pageName, // Added page name
  });
}

List<CategoryModel> categories = [
  CategoryModel(
    id: '1',
    name: 'Tour Plan',
    image: AppAssets.kTour,
    color: const Color(0xFFFFBC99),
    pageName: 'TourPlanPage', // Added page name
  ),
  CategoryModel(
    id: '2',
    name: 'Order',
    image: AppAssets.kBeauty,
    color: const Color(0xFFCABDFF),
    pageName: 'OrderPage', // Added page name
  ),
  CategoryModel(
    id: '3',
    name: 'Cart',
    image: AppAssets.kAppliance,
    color: const Color(0xFFB1E5FC),
    pageName: 'CartPage', // Added page name
  ),
  CategoryModel(
    id: '4',
    name: 'Submitted Order',
    image: AppAssets.kAppliance,
    color: const Color(0xFFB1E5FC),
    pageName: 'SubmittedOrderPage', // Added page name
  ),
   CategoryModel(
    id: '5',
    name: 'Order Dispatch Status',
    image: AppAssets.kAppliance,
    color: const Color(0xFFB1E5FC),
    pageName: 'OrderDispatchStatusPage', // Added page name
  ),
  CategoryModel(
    id: '6',
    name: 'Sales Analysis',
    image: AppAssets.kAppliance,
    color: const Color(0xFFB1E5FC),
    pageName: 'SalesAnalysisPage', // Added page name
  ),
  CategoryModel(
    id: '7',
    name: 'Ledger',
    image: AppAssets.kPaint,
    color: const Color(0xFFB5EBCD),
    pageName: 'LedgerPage', // Added page name
  ),
  CategoryModel(
    id: '8',
    name: 'Collection Report',
    image: AppAssets.kCleaning,
    color: const Color(0xFFFFD88D),
    pageName: 'CollectionReportPage', // Added page name
  ),
  CategoryModel(
    id: '9',
    name: 'Ageing Report Bill Wise',
    image: AppAssets.kPlumbing,
    color: const Color(0xFFCBEBA4),
    pageName: 'AgeingReportBillWisePage', // Added page name
  ),
  CategoryModel(
    id: '10',
    name: 'Ageing Without Payment Term',
    image: AppAssets.kElectronic,
    color: const Color(0xFFFB9B9B),
    pageName: 'AgeingSlabWithoutPaymentTermPage', // Added page name
  ),
  CategoryModel(
    id: '11',
    name: 'Ageing With Payment Term',
    image: AppAssets.kShifting,
    color: const Color(0xFFF8B0ED),
    pageName: 'AgeingSlabWithPaymentTermPage', // Added page name
  ),
];
