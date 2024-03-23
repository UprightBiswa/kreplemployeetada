import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/search_field.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_text_button.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({Key? key}) : super(key: key);

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  final TextEditingController _searchController = TextEditingController();

  // int? _selectedCustomerIndex;
  List<int> _selectedCustomerIndexes = [];
  List<Customer> _selectedCustomers = [];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Customer List'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            PrimaryContainer(
              child: Column(
                children: [
                  CustomHeaderText(text: 'Search Customer', fontSize: 18.sp),
                  SizedBox(height: 16.h),
                  SearchField(
                    controller: _searchController,
                    hintText: 'Search...',
                    buttonText: 'Search',
                    isSearchField: false,
                    onSearchPress: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            PrimaryContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomHeaderText(text: 'Customers', fontSize: 18.sp),
                      _selectedCustomerIndexes.isNotEmpty
                          ? CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedCustomerIndexes.clear();
                                });
                              },
                              text:
                                  'Clear All (${_selectedCustomerIndexes.length})',
                            )
                          : CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  // Clear the existing selected customer indexes
                                  _selectedCustomerIndexes.clear();
                                  // Add all customer indexes to the selected list
                                  for (int i = 0; i < customers.length; i++) {
                                    _selectedCustomerIndexes.add(i);
                                    _selectedCustomers.add(customers[i]);
                                  }
                                });
                              },
                              text: 'Select All',
                            ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CustomerCard(
                        onTap: () {
                          setState(() {
                            // _selectedCustomerIndex = index;
                            // _selectedCustomerIndex =
                            //     _selectedCustomerIndex == index ? null : index;
                            if (_selectedCustomerIndexes.contains(index)) {
                              _selectedCustomerIndexes.remove(index);
                              _selectedCustomers.remove(customers[index]);
                            } else {
                              _selectedCustomerIndexes.add(index);
                              _selectedCustomers.add(customers[index]);
                            }
                          });
                        },
                        // isSelected: _selectedCustomerIndex == index,
                        // customer: customers[index],
                        isSelected: _selectedCustomerIndexes.contains(index),
                        customer: customers[index],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(height: 20.h),
                    itemCount: customers.length,
                  ),
                ],
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomSheet: Container(
        color: isDarkMode(context) ? Colors.black : AppColors.kWhite,
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            PrimaryButton(
              onTap: () {
                if (_selectedCustomerIndexes.isNotEmpty) {
                  print('Selected customers:');
                  for (var customer in _selectedCustomers) {
                    print(customer.name);
                  }
                  Navigator.pop(context, _selectedCustomers);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a customer.'),
                    ),
                  );
                }
              },
              text: 'Select',
              color: _selectedCustomerIndexes.isNotEmpty
                  ? AppColors.kPrimary
                  : isDarkMode(context)
                      ? AppColors.kContentColor
                      : AppColors.kWhite,
              isBorder: true,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final Customer customer;

  const CustomerCard({
    Key? key,
    this.onTap,
    required this.isSelected,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(customer.image),
            radius: 25.w,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customer.name, style: AppTypography.kMedium16),
                SizedBox(height: 5.h),
                Text(
                  customer.description,
                  style: AppTypography.kLight13
                      .copyWith(color: AppColors.kNeutral),
                ),
              ],
            ),
          ),
          Container(
            height: 20.h,
            width: 20.w,
            padding: EdgeInsets.all(2.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.kPrimary, width: 2.w),
              shape: BoxShape.circle,
            ),
            child: isSelected
                ? Container(
                    decoration: const BoxDecoration(
                        color: AppColors.kPrimary, shape: BoxShape.circle),
                  )
                : null,
          )
        ],
      ),
    );
  }
}

class Customer {
  final String name;
  final String description;
  final String image;

  const Customer({
    required this.name,
    required this.description,
    required this.image,
  });
}

final List<Customer> customers = [
  Customer(
    name: 'John Doe',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  Customer(
    name: 'Jane Smith',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  // Add more customers here
  Customer(
    name: 'Alice Johnson',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  Customer(
    name: 'Bob Brown',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  // Add more customers as needed
  Customer(
    name: 'Michael Wilson',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  Customer(
    name: 'Emily Davis',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  // Add more customers as needed
];
