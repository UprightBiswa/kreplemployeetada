import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';

class SelectedItemView extends StatelessWidget {
  final String title;
  final List<dynamic> selectedItems; // Update to accept a list of dynamic items

  const SelectedItemView({
    Key? key,
    required this.title,
    required this.selectedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected $title:',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        // Display selected items dynamically
        Column(
          children: selectedItems.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: EdgeInsets.all(12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: null,
                  border: Border.all(color: AppColors.kHint),
                ),
                child: Row(
                  children: [
                    // Assuming all models have 'name', 'description', and 'image' properties
                    CircleAvatar(
                      backgroundImage: AssetImage(item.image),
                      radius: 25.w,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${item.name}',
                            style: AppTypography.kMedium16,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Description: ${item.description}',
                            style: AppTypography.kLight13
                                .copyWith(color: AppColors.kNeutral),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
