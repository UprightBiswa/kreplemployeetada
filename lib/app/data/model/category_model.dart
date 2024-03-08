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
    name: 'Beauty',
    image: AppAssets.kBeauty,
    color: const Color(0xFFCABDFF),
    pageName: 'BeautyPage', // Added page name
  ),
  CategoryModel(
    id: '3',
    name: 'Appliance',
    image: AppAssets.kAppliance,
    color: const Color(0xFFB1E5FC),
    pageName: 'AppliancePage', // Added page name
  ),
  CategoryModel(
    id: '4',
    name: 'Painting',
    image: AppAssets.kPaint,
    color: const Color(0xFFB5EBCD),
    pageName: 'PaintingPage', // Added page name
  ),
  CategoryModel(
    id: '5',
    name: 'Cleaning',
    image: AppAssets.kCleaning,
    color: const Color(0xFFFFD88D),
    pageName: 'CleaningPage', // Added page name
  ),
  CategoryModel(
    id: '6',
    name: 'Plumbing',
    image: AppAssets.kPlumbing,
    color: const Color(0xFFCBEBA4),
    pageName: 'PlumbingPage', // Added page name
  ),
  CategoryModel(
    id: '7',
    name: 'Electronics',
    image: AppAssets.kElectronic,
    color: const Color(0xFFFB9B9B),
    pageName: 'ElectronicsPage', // Added page name
  ),
  CategoryModel(
    id: '8',
    name: 'Shifting',
    image: AppAssets.kShifting,
    color: const Color(0xFFF8B0ED),
    pageName: 'ShiftingPage', // Added page name
  ),
  CategoryModel(
    id: '9',
    name: "Men's Salon",
    image: AppAssets.kFacial,
    color: const Color(0xFFAFC6FF),
    pageName: 'MensSalonPage', // Added page name
  ),
];
