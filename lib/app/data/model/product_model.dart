import 'package:kreplemployee/app/data/constants/constants.dart';

class ProductsModel {
  String id;
  String image;
  String name;
  int totalRatings;
  double averageRatings;
  double price;
  String? discount;

  ProductsModel({
    required this.id,
    required this.image,
    required this.name,
    required this.totalRatings,
    required this.averageRatings,
    required this.price,
    this.discount,
  });
}

List<ProductsModel> allServices = [
  ...acRepair,
];

List<ProductsModel> acRepair = [
  ProductsModel(
    id: '8',
    image: AppAssets.kApplianceService1,
    name: 'AC Check-Up',
    totalRatings: 5,
    averageRatings: 3.5,
    price: 100.0,
  ),
  ProductsModel(
    id: '9',
    image: AppAssets.kApplianceService2,
    name: 'AC Regular Service',
    totalRatings: 7,
    averageRatings: 4.2,
    price: 80.0,
  ),
  ProductsModel(
    id: '10',
    image: AppAssets.kApplianceService3,
    name: 'AC Installation',
    totalRatings: 3,
    averageRatings: 3.0,
    price: 200.0,
  ),
  ProductsModel(
    id: '11',
    image: AppAssets.kApplianceService4,
    name: 'AC Uninstallation',
    totalRatings: 2,
    averageRatings: 2.5,
    price: 150.0,
  ),
  ProductsModel(
    id: '12',
    image: AppAssets.kApplianceService1,
    name: 'AC Check-Up',
    totalRatings: 5,
    averageRatings: 3.5,
    price: 100.0,
  ),
  ProductsModel(
    id: '13',
    image: AppAssets.kApplianceService2,
    name: 'AC Regular Service',
    totalRatings: 7,
    averageRatings: 4.2,
    price: 80.0,
  ),
  ProductsModel(
    id: '14',
    image: AppAssets.kApplianceService3,
    name: 'AC Installation',
    totalRatings: 3,
    averageRatings: 3.0,
    price: 200.0,
  ),
  ProductsModel(
    id: '15',
    image: AppAssets.kApplianceService4,
    name: 'AC Uninstallation',

    totalRatings: 2,
    averageRatings: 2.5,
    price: 150.0,
  ),
];

String loremIpsumText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis nulla at dapibus ultricies. Suspendisse id massa eget dolor luctus hendrerit eu ac dui.';
