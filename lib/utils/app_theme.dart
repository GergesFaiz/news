import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.whiteColor,
      splashColor: AppColors.blackColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          iconTheme: IconThemeData(color: AppColors.blackColor),
          centerTitle: true),

      textTheme: TextTheme(

        displayMedium: AppStyles.medium14White,

      labelLarge: AppStyles.bold16Black,
      labelSmall: AppStyles.medium12Gray,
      labelMedium: AppStyles.medium14Black,
      headlineMedium: AppStyles.medium24Black,
      headlineLarge: AppStyles.medium20Black,
      titleLarge: AppStyles.medium26Black,
        titleMedium:  AppStyles.bold20Black,
      )

  );

  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.blackColor,
      splashColor: AppColors.whiteColor,
      scaffoldBackgroundColor: AppColors.blackColor,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.blackColor,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ),
      textTheme: TextTheme(

        displayMedium: AppStyles.medium14Black,

      labelLarge: AppStyles.bold16White,
      labelMedium: AppStyles.medium14White,
      labelSmall : AppStyles.medium12Gray,
      headlineMedium: AppStyles.medium24White,
      headlineLarge: AppStyles.medium20White,
        titleLarge: AppStyles.medium26White,
        titleMedium:  AppStyles.bold20White,
      )

  );
}