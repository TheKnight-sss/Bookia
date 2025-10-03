import 'package:bookia/Components/app_bar_with_back.dart';
import 'package:bookia/Components/inputs/custom_text_field.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Welcome back! Glad to see you, Again!", style: TextStyles.styleSize30(),
            ),
            Gap(30),
            CustomTextField(
              controller: emailController,
              hint : 'Email'
            ),
            Gap(20),
            CustomTextField()
          ],
        ),
      )
    );
  }
}
