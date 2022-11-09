import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iec_app/app/modules/cart/views/screens/cart_screen.dart';
import 'package:iec_app/app/modules/category/views/screens/all_categories_screen.dart';
import 'package:iec_app/app/modules/home/views/screens/home_screen.dart';
import 'package:iec_app/app/modules/profile/views/screens/profile_screen.dart';
import 'package:iec_app/app/shared/utils/theme/app_color.dart';

class BottomNavBarWidget extends ConsumerStatefulWidget {
  const BottomNavBarWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends ConsumerState<BottomNavBarWidget> {
  final screens = [
    const HomeScreen(),
    const CartScreen(),
    const AllCategoryScreen(),
    const ProfileScreen()
  ];
  int currentIndex = 0;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColor.whiteColor,
              selectedItemColor: AppColor.blackColor,
              unselectedItemColor: AppColor.brightTextColor,
              iconSize: 30.0,
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/home.svg',
                    height: 24,
                    width: 24,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svgs/home.svg',
                    height: 24,
                    width: 24,
                    color: AppColor.primaryColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/cart.svg',
                    height: 24,
                    width: 24,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svgs/cart.svg',
                    height: 24,
                    width: 24,
                    color: AppColor.primaryColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/heart.svg',
                    height: 24,
                    width: 24,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svgs/heart.svg',
                    height: 24,
                    width: 24,
                    color: AppColor.primaryColor,
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline,
                  ),
                  activeIcon: Icon(
                    Icons.person_outline,
                    color: AppColor.primaryColor,
                  ),
                  label: '',
                ),
              ])),
    );
  }
}
