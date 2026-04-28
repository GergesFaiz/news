import 'package:flutter/material.dart';
import 'package:news/home/drawer/divider_item.dart';
import 'package:news/home/drawer/drawer_item.dart';
import 'package:news/providers/language_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/utils/app_assets.dart';
import 'package:news/utils/screen_utils.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final Function onDrawerClick;
  final VoidCallback? onSearchClick;

  const HomeDrawer({
    required this.onDrawerClick,
    this.onSearchClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();

    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
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
          SizedBox(height: height * 0.02),
          // Go Home
          InkWell(
            onTap: () => onDrawerClick(),
            child: DrawerItem(iconName: AppAssets.homeIcon, name: 'Go To Home'),
          ),
          SizedBox(height: height * 0.02),
          DividerItem(),
          SizedBox(height: height * 0.02),

          // Theme section
          DrawerItem(iconName: AppAssets.themeIcon, name: 'Theme'),
          SizedBox(height: height * 0.01),
          _ToggleOption(
            label: themeProvider.isDark ? 'Dark' : 'Light',
            onPressed: () => themeProvider.toggleTheme(),
          ),

          SizedBox(height: height * 0.02),
          DividerItem(),
          SizedBox(height: height * 0.02),

          // Language section
          DrawerItem(iconName: AppAssets.languageIcon, name: 'Language'),
          SizedBox(height: height * 0.01),
          _ToggleOption(
            label: languageProvider.languageLabel,
            onPressed: () => languageProvider.toggleLanguage(),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ToggleOption({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).splashColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).splashColor),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.swap_horiz_rounded,
              size: 28,
              color: Theme.of(context).splashColor,
            ),
          ),
        ],
      ),
    );
  }
}
