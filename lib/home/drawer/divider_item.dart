import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/screen_utils.dart';

class DividerItem extends StatelessWidget {
  const DividerItem({super.key});

  Widget build(BuildContext context) {
    var  width = context.width;
    return Divider(
      color: AppColors.whiteColor,
      endIndent: width * 0.06,
      indent: width * 0.06,
      thickness: 2,
    );
  }
}