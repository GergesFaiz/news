import 'package:flutter/material.dart';
import 'package:news/model/Category.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/screen_utils.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final int index;

  const CategoryItem({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    var isEven = index % 2 == 0;
    var width = context.width;
    var height = context.height;
    return Stack(
      alignment: isEven ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(category.image),
        ),
        Column(
          spacing: height * 0.04,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).primaryColor,fontSize: 36
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              padding: EdgeInsetsDirectional.only(
                start: isEven ? width * 0.04 : 0,
                end: isEven ? 0 : width * 0.04,
              ),
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                spacing: width * 0.02,
                textDirection: isEven ? TextDirection.ltr : TextDirection.rtl,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View All',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      isEven
                          ? Icons.arrow_forward_ios
                          : Icons.arrow_back_ios_new_outlined,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
