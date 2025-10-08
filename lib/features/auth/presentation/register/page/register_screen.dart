import 'dart:developer';
import 'package:bookia/Components/app_bar_with_back.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/inputs/custom_text_field.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(),
      body: _buildLoginBody(context),
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

  Widget _buildLoginBody(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit,AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
          
        }else if(state is AuthSuccessState){
          pop(context);
          log("Registration Success");

        }else if(state is AuthErrorState){
          pop(context);
          ShowErrorDialog(context, "Registeration Failed");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: cubit.formkey,
          child: Column(
            children: [
              Text(
                "Hello! Register to get started",
                style: TextStyles.styleSize30(),
              ),
              Gap(30),
              CustomTextField(
                controller: cubit.nameController,
                hint: "UseName",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name is required";
                  }else{
                    return null;
                  }
                },
              ),
              Gap(12),
              CustomTextField(
                controller: cubit.emailController,
                hint: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "email is required";
                  }else{
                    return null;
                  }
                },
              ),
              Gap(12),
              CustomTextField(
                controller: cubit.passwordController,
                hint: "Password",
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [SvgPicture.asset(AppImages.eye)],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "password is required";                  
                  }else{
                    return null;
                  }
                }
              ),
              Gap(12),
              CustomTextField(
                controller: cubit.confirmpasswordController,
                hint: "ConfirmPassword",
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [SvgPicture.asset(AppImages.eye)],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "ConfirmPassword is required";                  
                  }else{
                    return null;
                  }
                }
              ),
      
              Gap(30),
              MainButton(
                text: "Resgister",
                onPressed: () {
                  if (cubit.formkey.currentState!.validate()) {
                    cubit.register();
                  }
                },
              ),
              Gap(34),
            ],
          ),
        ),
      ),
    );
  }
}
