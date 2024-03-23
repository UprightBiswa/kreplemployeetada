import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kreplemployee/app/data/model/pages_model.dart';
import 'package:kreplemployee/app/presentation/pages/menus/components/pages_card.dart';
import 'package:kreplemployee/app/presentation/pages/home/components/search_field.dart';
import 'package:kreplemployee/app/presentation/widgets/animations/grid_animation.dart';
import 'package:kreplemployee/app/presentation/widgets/containers/primary_container.dart';
import 'package:kreplemployee/app/presentation/widgets/texts/custom_header_text.dart';

class AllPages extends StatefulWidget {
  const AllPages({super.key});

  @override
  State<AllPages> createState() => _AllPagesState();
}

class _AllPagesState extends State<AllPages> {
  final TextEditingController _searchController = TextEditingController();
  List<CategoryModel> filteredCategories = [];

  @override
  void initState() {
    filteredCategories = categories;
    super.initState();
  }

  void filterCategories(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCategories = categories;
      } else {
        filteredCategories = categories
            .where((category) =>
                category.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

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
              controller: _searchController,
              onSearchPress: () {
                filterCategories(_searchController.text);
              },
            )),
            SizedBox(height: 16.h),
            CustomHeaderText(text: 'All Categories', fontSize: 18.sp),
            SizedBox(height: 16.h),
            PrimaryContainer(
                child: filteredCategories.isEmpty
                    ? Center(
                        child: Text(
                          'No categories found',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 73 / 90,
                            crossAxisSpacing: 20.h,
                            mainAxisSpacing: 10.w),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredCategories.length,
                        itemBuilder: ((context, index) {
                          return GridAnimatorWidget(
                              child: PagesCard(
                            category: filteredCategories[index],
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
