import 'dart:developer';

import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/auth/data/models/auth_response/data.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  UserModel?  userData;

  @override
  void initState() {
    userData = SharedPref.getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(
        builder: (context) {
          var cubit = context.read<AuthCubit>();
          final name = userData?.user?.name ?? "";
          final email = userData?.user?.email ?? "";
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                showLoadingDialog(context);
              } else if (state is AuthSuccessState) {
                pop(context);
                log("Success");
                goToBase(context, Routes.splash);
              } else {
                pop(context);
                showMyDialog(context, "Faild", type: Dialogs.error);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text("profile".tr()),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      onTap: () {
                        cubit.logout();
                      },
                      child: SvgPicture.asset(AppImages.logout, width: 30),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyles.styleSize24()),
                    Gap(10),
                    Text(
                      email,
                      style: TextStyles.styleSize16(color: AppColor.greyColor),
                    ),
                    Gap(30),
                    ProfileItem(title: "my_orders".tr(), onTap: () {}),
                    Gap(20),
                    ProfileItem(
                      title: "edit_profile".tr(),
                      onTap: () {},
                    ),
                    Gap(20),
                    ProfileItem(title: "faq".tr(), onTap: () {}),
                    Gap(20),
                    ProfileItem(
                      title: "contact_us".tr(),
                      onTap: () {},
                    ),
                    Gap(20),
                    ProfileItem(title: "privacy".tr(), onTap: () {}),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}