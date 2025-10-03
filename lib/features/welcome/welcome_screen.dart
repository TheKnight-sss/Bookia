import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcome,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                SvgPicture.asset(AppImages.logosvg, width: 220),
                Gap(20),
                Text("Order Your Book Now!", style: TextStyles.styleSize18()),
                Spacer(flex: 3),

                MainButton(text: "Login", onPressed: () {
                  pushTo(context, Routes.login);
                }),
                Gap(10),
                MainButton(
                  text: "Sign Up",
                  borderColor: AppColor.darkColor,
                  bgColor: AppColor.whiteColor,
                  textColor: AppColor.darkColor,
                  onPressed: () {},
                ),
                Gap(80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
