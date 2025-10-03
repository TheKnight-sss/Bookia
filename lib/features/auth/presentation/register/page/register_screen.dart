import 'package:bookia/Components/app_bar_with_back.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/inputs/custom_text_field.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(),
      body: _buildLoginBody(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an Account?"),
          TextButton(
            onPressed: () {
              pushwithReplacement(context, Routes.login);
            },
            child: Text(
              "Sign In",
              style: TextStyles.styleSize16(color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildLoginBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Hello! Register to get started",
            style: TextStyles.styleSize30(),
          ),
          Gap(30),
          CustomTextField(controller: nameController, hint: "UseName"),
          Gap(12),
          CustomTextField(controller: emailController, hint: 'Email'),
          Gap(12),
          CustomTextField(
            controller: passwordController,
            hint: "Password",
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [SvgPicture.asset(AppImages.eye)],
            ),
          ),
          Gap(12),
          CustomTextField(
            controller: confirmpasswordController,
            hint: "ConfirmPassword",
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [SvgPicture.asset(AppImages.eye)],
            ),
          ),

          Gap(30),
          MainButton(text: "Resgister", onPressed: () {}),
          Gap(34),
        ],
      ),
    );
  }
}
