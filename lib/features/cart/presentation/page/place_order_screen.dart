import 'package:bookia/Components/app_bar_with_back.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/inputs/custom_text_field.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/cart/data/model/gov_list.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();
    return Scaffold(
      appBar: AppBarWithBack(),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartStateLoadingState) {
            showLoadingDialog(context);
          } else if (state is CartStateSuccessState) {
            pop(context);
            goToBase(context, Routes.main, extra: 0);
          } else if (state is CartStateFailureState) {
            pop(context);
            showMyDialog(context,  "Failed to place order");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Place Order', style: TextStyles.styleSize30()),
                  Text(
                    'Don\'t worry! It occurs. Please enter the email \n address linked with your account.',
                    style: TextStyles.styleSize16(color: AppColor.greyColor),
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: cubit.fullnameController,
                    hint: "Full Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextField(
                    controller: cubit.emailController,
                    hint: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextField(
                    controller: cubit.addressController,
                    hint: "Address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextField(
                    controller: cubit.phoneController,
                    hint: "Phone",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextField(
                    controller: cubit.governorateController,
                    hint: "Governorate",
                    readOnly: true,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    onTap: () {
                      selectGovernorate(context, cubit);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your governorate';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price", style: TextStyles.styleSize18()),
                Text('$total\$', style: TextStyles.styleSize18()),
              ],
            ),
            Gap(20),
            MainButton(text: 'Place Order', onPressed: () {
              cubit.placeOrder();
            }),
          ],
        ),
      ),
    );
  }

  Future<dynamic> selectGovernorate(BuildContext context, CartCubit cubit) {
    return showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Governorate',
                                style: TextStyles.styleSize20(),
                              ),
                              Divider(),
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(
                                            governorateList[index]
                                                    .governorateNameEn ??
                                                "",
                                          ),
                                          leading: Icon(Icons.location_city),
                                          trailing: cubit.selectedGovId ==
                                                  governorateList[index].id
                                              ? Icon(
                                                  Icons.check,
                                                  color: AppColor.primaryColor,
                                                )
                                              : null,
                                          subtitle: Text("Giza"),
                                          onTap: () {
                                            pop(context);
                                            cubit.governorateController.text =
                                                governorateList[index]
                                                    .governorateNameEn ??
                                                "";
                                            cubit.selectedGovId =
                                                governorateList[index].id ?? 0;
                                          },
                                        );
                                      },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                        return Divider();
                                      },
                                  itemCount: governorateList.length,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
  }
}
