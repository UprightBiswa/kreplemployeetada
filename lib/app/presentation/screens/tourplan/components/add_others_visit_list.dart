import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/search_field.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_text_button.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class OthersListPage extends StatefulWidget {
  const OthersListPage({Key? key}) : super(key: key);

  @override
  State<OthersListPage> createState() => _OthersListPageState();
}

class _OthersListPageState extends State<OthersListPage> {
  final TextEditingController _searchController = TextEditingController();

  List<int> _selectedOtherIndexes = [];
  List<Other> _selectedOthers = [];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Others List'),
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
                  CustomHeaderText(text: 'Search Others', fontSize: 18.sp),
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
                      CustomHeaderText(text: 'Others', fontSize: 18.sp),
                      _selectedOtherIndexes.isNotEmpty
                          ? CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedOtherIndexes.clear();
                                });
                              },
                              text:
                                  'Clear All (${_selectedOtherIndexes.length})',
                            )
                          : CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  // Clear the existing selected customer indexes
                                  _selectedOtherIndexes.clear();
                                  // Add all customer indexes to the selected list
                                  for (int i = 0; i < others.length; i++) {
                                    _selectedOtherIndexes.add(i);
                                    _selectedOthers.add(others[i]);
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
                      return OtherCard(
                        onTap: () {
                          setState(() {
                            if (_selectedOtherIndexes.contains(index)) {
                              _selectedOtherIndexes.remove(index);
                              _selectedOthers.remove(others[index]);
                            } else {
                              _selectedOtherIndexes.add(index);
                              _selectedOthers.add(others[index]);
                            }
                          });
                        },
                        isSelected: _selectedOtherIndexes.contains(index),
                        other: others[index],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(height: 20.h),
                    itemCount: others.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: isDarkMode(context) ? Colors.black : AppColors.kWhite,
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            PrimaryButton(
              onTap: () {
                if (_selectedOtherIndexes.isNotEmpty) {
                  print('Selected customers:');
                  for (var customer in _selectedOthers) {
                    print(customer.name);
                  }
                  Navigator.pop(context, _selectedOthers);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a customer.'),
                    ),
                  );
                }
              },
              text: 'Select',
              color: _selectedOtherIndexes.isNotEmpty
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

class OtherCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final Other other;

  const OtherCard({
    Key? key,
    this.onTap,
    required this.isSelected,
    required this.other,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(other.image),
            radius: 25.w,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(other.name, style: TextStyle(fontSize: 16.sp)),
                SizedBox(height: 5.h),
                Text(other.description),
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

class Other {
  final String name;
  final String description;
  final String image;

  const Other({
    required this.name,
    required this.description,
    required this.image,
  });
}

final List<Other> others = [
  Other(
    name: 'Other A',
    description: 'Other description...',
    image: AppAssets.kLogo,
  ),
  Other(
    name: 'Other B',
    description: 'Other description...',
    image: AppAssets.kLogo,
  ),
  // Add more "Other" items as needed
];
