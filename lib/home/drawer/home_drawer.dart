import 'package:flutter/material.dart';
import 'package:news/home/drawer/config_option.dart';
import 'package:news/home/drawer/divider_item.dart';
import 'package:news/home/drawer/drawer_item.dart';
import 'package:news/utils/app_assets.dart';
import 'package:news/utils/screen_utils.dart';

class HomeDrawer extends StatelessWidget {
  final Function onHomePress;

  const HomeDrawer({required this.onHomePress, super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        spacing: height * 0.02,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).splashColor),
            child: Center(
              child: Text(
                "News App",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              onHomePress();
            },
            child: DrawerItem(iconName: AppAssets.homeIcon, name: 'Go To Home'),
          ),
          DividerItem(),
          DrawerItem(iconName: AppAssets.themeIcon, name: 'Theme'),
          ConfigOption(name: 'Dark', onPressed: () {}),
          DividerItem(),
          DrawerItem(iconName: AppAssets.languageIcon, name: 'Language'),
          ConfigOption(name: 'English', onPressed: () {}),
        ],
      ),
    );
  }
}
