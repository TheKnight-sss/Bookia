import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widget/best_seller_builder.dart';
import 'package:bookia/features/home/presentation/widget/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getBestSeller()
        ..getSlider(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: SvgPicture.asset(AppImages.logosvg, height: 30),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppImages.search),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();

            if (state is! HomeSuccessState) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeSlider(sliders: cubit.sliders),
                    BestSellerBuilder(books: cubit.products),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
