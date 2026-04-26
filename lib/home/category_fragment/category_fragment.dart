import 'package:flutter/material.dart';
import 'package:news/home/category_fragment/category_item.dart';
import 'package:news/model/category_model.dart';
import 'package:news/utils/screen_utils.dart';

class CategoryFragment extends StatelessWidget {
  const CategoryFragment({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var category =Category.getCategoriesList(isDark: true);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        spacing: height*0.02,
        children: [
          Text(
            'Good Morning\nHere is Some News For You',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context,  index) {
                return CategoryItem(category: category[index],index: index,);
              },

              separatorBuilder: (context, index) {
                return SizedBox(height: height * 0.02);
              },

              itemCount: category.length,
            ),
          ),
        ],
      ),
    );
  }
}
