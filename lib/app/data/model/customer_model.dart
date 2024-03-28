import 'package:kreplemployee/app/data/constants/constants.dart';

class Customer {
  final String name;
  final String description;
  final String image;
  final String customerNumber;
  final String companyCode;

  const Customer({
    required this.name,
    required this.description,
    required this.image,
    required this.customerNumber,
    required this.companyCode,
  });
}

final List<Customer> customers = [
  Customer(
    name: 'John Doe',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105343',
    companyCode: '1000',
  ),
  Customer(
    name: 'Jane Smith',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105344',
    companyCode: '1001',
  ),
  // Add more customers here
  Customer(
    name: 'Alice Johnson',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105345',
    companyCode: '1002',
  ),
  Customer(
    name: 'Bob Brown',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105346',
    companyCode: '1003',
  ),
  // Add more customers as needed
  Customer(
    name: 'Michael Wilson',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105347',
    companyCode: '1004',
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105348',
    companyCode: '1005',
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105349',
    companyCode: '1006',
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105350',
    companyCode: '1007',
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105351',
    companyCode: '1008',
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
    customerNumber: '0001105352',
    companyCode: '1009',
  ),
  // Add more customers as needed
];
