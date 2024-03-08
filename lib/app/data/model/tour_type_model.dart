import 'package:kreplemployee/app/data/constants/constants.dart';

class TourType {
  String id;
  String image;
  String name;

  TourType({
    required this.id,
    required this.image,
    required this.name,
  });
}

List<TourType> tourTypes = [
  TourType(id: '1', image: AppAssets.kOffice, name: 'Customer Visit'),
  TourType(id: '2', image: AppAssets.kVila, name: 'Village Visit'),
  TourType(id: '3', image: AppAssets.kHome, name: 'Others'),
];
