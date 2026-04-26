import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/utils/screen_utils.dart';

class ConfigOption extends StatelessWidget {
  final String name;
  VoidCallback onPressed;

   ConfigOption({super.key, required this.name,required this.onPressed});


  @override
  Widget build(BuildContext context) {
    var width = context.width;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.04
      ), padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,

    ), decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
          color: AppColors.whiteColor,
          width: 2

      ),

    ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: AppStyles.medium20White),
          IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.arrow_drop_down_rounded, size: 40,color: AppColors.whiteColor,),)

        ],

      ),


    );
  }
}