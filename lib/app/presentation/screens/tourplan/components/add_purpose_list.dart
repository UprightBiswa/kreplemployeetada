import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/search_field.dart';
import 'package:kreplemployee/app/presentation/widgets/buttons/primary_button.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class PurposeListPage extends StatefulWidget {
  const PurposeListPage({Key? key}) : super(key: key);

  @override
  State<PurposeListPage> createState() => _PurposeListPageState();
}

class _PurposeListPageState extends State<PurposeListPage> {
  final TextEditingController _searchController = TextEditingController();

  int? _selectedPurposeIndex;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Purpose List'),
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
                  CustomHeaderText(text: 'Search Purpose', fontSize: 18.sp),
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
                  CustomHeaderText(text: 'Purpose', fontSize: 18.sp),
                  SizedBox(height: 16.h),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PurposeCard(
                        onTap: () {
                          setState(() {
                            // _selectedPurposeIndex = index;
                            _selectedPurposeIndex =
                                _selectedPurposeIndex == index ? null : index;
                          });
                        },
                        isSelected: _selectedPurposeIndex == index,
                        purpose: purposes[index],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(height: 20.h),
                    itemCount: purposes.length,
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
                if (_selectedPurposeIndex != null) {
                  Purpose selectedCustomer = purposes[_selectedPurposeIndex!];
                  print('Selected Purpose name: ${selectedCustomer.name}');
                  Navigator.pop(context, [selectedCustomer]);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a Purpose.'),
                    ),
                  );
                }
              },
              text: 'Select',
              color: _selectedPurposeIndex != null
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

class PurposeCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final Purpose purpose;

  const PurposeCard({
    Key? key,
    this.onTap,
    required this.isSelected,
    required this.purpose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(purpose.image),
            radius: 25.w,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(purpose.name, style: AppTypography.kMedium16),
                SizedBox(height: 5.h),
                Text(
                  purpose.description,
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

class Purpose {
  final String name;
  final String description;
  final String image;

  const Purpose({
    required this.name,
    required this.description,
    required this.image,
  });
}

final List<Purpose> purposes = [
  Purpose(
    name: 'John Doe',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
  Purpose(
    name: 'Jane Smith',
    description: 'Customer description...',
    image: AppAssets.kLogo,
  ),
];
