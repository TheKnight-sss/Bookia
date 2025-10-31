import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/features/cart/presentation/page/cart_screen.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:bookia/features/profile/presentation/page/profile_screen.dart';
import 'package:bookia/features/wishlist/presentation/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, this.index});

  final int? index;

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? _currentIndex;
  }

  @override
  void didUpdateWidget(covariant MainAppScreen oldWidget) {
    _currentIndex = widget.index ?? _currentIndex;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _buildNavBarItem(label: "Home", iconpath: AppImages.home),
          _buildNavBarItem(label: "WishList", iconpath: AppImages.bookmark),
          _buildNavBarItem(label: "Cart", iconpath: AppImages.category),
          _buildNavBarItem(label: "Profile", iconpath: AppImages.profile),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required String label,
    required String iconpath,
  }) {
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        iconpath,
        colorFilter: ColorFilter.mode(AppColor.primaryColor, BlendMode.srcIn),
      ),
      icon: SvgPicture.asset(iconpath),
      label: label,
    );
  }
}
