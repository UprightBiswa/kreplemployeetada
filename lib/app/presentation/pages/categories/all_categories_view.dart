
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/model/category_model.dart';
import 'package:kreplemployee/app/presentation/pages/categories/components/category_card.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/search_field.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/grid_animation.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            PrimaryContainer(
                child: SearchField(
                    controller: _searchController, onSearchPress: () {})),
            SizedBox(height: 16.h),
            CustomHeaderText(text: 'All Categories', fontSize: 18.sp),
            SizedBox(height: 16.h),
            PrimaryContainer(
                child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 73 / 90,
                  crossAxisSpacing: 30.h,
                  mainAxisSpacing: 5.w),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: ((context, index) {
                return GridAnimatorWidget(
                    child: CategoryCard(
                  category: categories[index],
                  isGridView: true,
                ));
              }),
            ))
          ],
        ),
      ),
    );
  }
}
