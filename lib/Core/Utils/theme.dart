import 'package:bookia/Core/Constants/app_fonts.dart';
import 'package:bookia/Core/Utils/colors.dart';
import 'package:bookia/Core/Utils/text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColor.whiteColor,
    primaryColor: AppColor.primaryColor,
    fontFamily: AppFonts.poppinsfamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.whiteColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor,
    onSurface: AppColor.darkColor),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.styleSize14(
        color: AppColor.greyColor,
      ),
    ),
  );

    
}