import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/search_field.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/custom_text_button.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class VillageListPage extends StatefulWidget {
  const VillageListPage({Key? key}) : super(key: key);

  @override
  State<VillageListPage> createState() => _VillageListPageState();
}

class _VillageListPageState extends State<VillageListPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<int> _selectedVillageIndexes = [];
  final List<Village> _selectedVillages = [];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Village List'),
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
                  CustomHeaderText(text: 'Search Village', fontSize: 18.sp),
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
                      CustomHeaderText(text: 'Villages', fontSize: 18.sp),
                      _selectedVillageIndexes.isNotEmpty
                          ? CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedVillageIndexes.clear();
                                  _selectedVillages.clear();
                                });
                              },
                              text:
                                  'Clear All (${_selectedVillageIndexes.length})',
                            )
                          : CustomTextButton(
                              onPressed: () {
                                setState(() {
                                  // Clear the existing selected customer indexes
                                  _selectedVillageIndexes.clear();
                                  // Add all customer indexes to the selected list
                                  for (int i = 0; i < villages.length; i++) {
                                    _selectedVillageIndexes.add(i);
                                    _selectedVillages.add(villages[i]);
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
                      return VillageCard(
                        onTap: () {
                          setState(() {
                            if (_selectedVillageIndexes.contains(index)) {
                              _selectedVillageIndexes.remove(index);
                              _selectedVillages.remove(villages[index]);
                            } else {
                              _selectedVillageIndexes.add(index);
                              _selectedVillages.add(villages[index]);
                            }
                          });
                        },
                        isSelected: _selectedVillageIndexes.contains(index),
                        village: villages[index],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(height: 20.h),
                    itemCount: villages.length,
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
                if (_selectedVillageIndexes.isNotEmpty) {
                  print('Selected villages:');
                  for (var village in _selectedVillages) {
                    print(village.name);
                  }
                  Navigator.pop(context, _selectedVillages);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a customer.'),
                    ),
                  );
                }
              },
              text: 'Select',
              color: _selectedVillageIndexes.isNotEmpty
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

class VillageCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final Village village;

  const VillageCard({
    Key? key,
    this.onTap,
    required this.isSelected,
    required this.village,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(village.image),
            radius: 25.w,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(village.name, style: TextStyle(fontSize: 16.sp)),
                SizedBox(height: 5.h),
                Text(village.description),
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

class Village {
  final String name;
  final String description;
  final String image;

  const Village({
    required this.name,
    required this.description,
    required this.image,
  });
}

final List<Village> villages = [
  Village(
    name: 'Village A',
    description: 'Village description...',
    image: AppAssets.kLogo,
  ),
  Village(
    name: 'Village B',
    description: 'Village description...',
    image: AppAssets.kLogo,
  ),
  // Add more villages as needed
];
