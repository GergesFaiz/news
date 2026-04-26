import 'package:flutter/material.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/utils/screen_utils.dart';

class DrawerItem extends StatelessWidget {
  final String iconName;

  final String name;

  const DrawerItem({super.key, required this.iconName, required this.name});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.02),
      child: Row(
        spacing: width * 0.02,
        children: [
          Image.asset(iconName),
          Text(name, style: AppStyles.bold20White),
        ],
      ),
    );
  }
}
