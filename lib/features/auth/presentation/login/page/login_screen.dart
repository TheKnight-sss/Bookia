import 'package:bookia/Components/app_bar_with_back.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/inputs/custom_text_field.dart';
import 'package:bookia/Components/inputs/password_text_field.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/login/widgets/social_login.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(),
      body: SingleChildScrollView(child: _buildLoginBody()),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don\'t have an Account?"),
          TextButton(
            onPressed: () {
              goToBase(context, Routes.register);
            },
            child: Text(
              "Sign Up",
              style: TextStyles.styleSize16(color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBody() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthSuccessState) {
          goToBase(context, Routes.main);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Welcome back! Glad to see you, Again!",
              style: TextStyles.styleSize30(),
            ),
            Gap(30),
            CustomTextField(controller: emailController, hint: 'Email'),
            Gap(20),
            PasswordTextField(controller: passwordController, hint: "Password"),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(overlayColor: Colors.transparent),
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyles.styleSize16(color: AppColor.primaryColor),
                ),
              ),
            ),
            Gap(30),
            MainButton(text: "Login", onPressed: () {}),
            Gap(34),
            Text(
              "or",
              style: TextStyles.styleSize18(color: AppColor.greyColor),
            ),
            Gap(24),
            SocialButton(image: AppImages.google, txtbt: "Sign in with google"),
            Gap(48),
            SocialButton(image: AppImages.apple, txtbt: "Sign in with Apple"),
          ],
        ),
      ),
    );
  }
}
