import 'package:flutter/material.dart';
import 'package:news/home/category_fragment/category_item.dart';
import 'package:news/model/Category.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/utils/screen_utils.dart';
import 'package:provider/provider.dart';

typedef OnCategoryClick = void Function(Category);

class CategoryFragment extends StatelessWidget {
  final OnCategoryClick onCategoryClick;

  const CategoryFragment({super.key, required this.onCategoryClick});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    final isDark = context.watch<ThemeProvider>().isDark;
    var categoriesList = Category.getCategoriesList(isDark: isDark);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.02),
            Text(
              'Good Morning\nHere is Some News For You',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: height * 0.02),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onCategoryClick(categoriesList[index]);
                  },
                  child: CategoryItem(
                    category: categoriesList[index],
                    index: index,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: height * 0.02);
              },
              itemCount: categoriesList.length,
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
