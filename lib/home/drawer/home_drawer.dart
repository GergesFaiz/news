import 'package:flutter/material.dart';
import 'package:news/home/drawer/divider_item.dart';
import 'package:news/home/drawer/drawer_item.dart';
import 'package:news/home/drawer/option_widget.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/providers/language_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/utils/app_assets.dart';
import 'package:news/utils/screen_utils.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final Function onDrawerClick;
  final VoidCallback? onSearchClick;

  HomeDrawer({
    required this.onDrawerClick,
    this.onSearchClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();
    String language = 'ssssssssssssssss';
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).splashColor),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.newsApp,
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
            child: DrawerItem(iconName: AppAssets.homeIcon,
                name: AppLocalizations.of(context)!.goToHome),
          ),
          SizedBox(height: height * 0.02),
          DividerItem(),
          SizedBox(height: height * 0.02),
          // Theme section
          DrawerItem(iconName: AppAssets.themeIcon,
              name: AppLocalizations.of(context)!.theme),
          SizedBox(height: height * 0.01),
          OptionWidget(
            label: themeProvider.isDark
                ? AppLocalizations.of(context)!.dark
                : AppLocalizations.of(context)!.light,
            onPressed: () => themeProvider.toggleTheme(),
          ),

          SizedBox(height: height * 0.02),
          DividerItem(),
          SizedBox(height: height * 0.02),

          // Language section
          DrawerItem(iconName: AppAssets.languageIcon,
              name: AppLocalizations.of(context)!.language),
          SizedBox(height: height * 0.01),
          OptionWidget(
            label: languageProvider.isEnglish ? AppLocalizations.of(context)!.english : AppLocalizations.of(context)!.arabic,
            onPressed: () => languageProvider.changeLanguage(),
          ),
        ],
      ),
    );
  }
}


