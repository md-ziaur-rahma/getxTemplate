import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/core/app_colors.dart';
import 'package:getx/app/modules/account/screens/account_screen.dart';
import 'package:getx/app/modules/home/screens/home_screen.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;

  var pageController = PageController(
    initialPage: 0,
  );

  void onPageChange(int index) {
    _changePage(index);
  }

  List<Widget> screenList = [
    const HomeScreen(),
    Scaffold(
      backgroundColor: AppColors.pageBackground2,
      body: const Center(
        child: Text("Category Page"),
      ),
    ),
    Scaffold(
      backgroundColor: AppColors.pageBackground2,
      body: const Center(
        child: Text("Cart Page"),
      ),
    ),
    const AccountScreen(),
  ];

  void _changePage(int index) {
    int difference = (currentIndex.value - index);
    int duration = (difference == 1 || difference == -1) ? 500 : 1;
    currentIndex.value = index;
    pageController.animateToPage(
      currentIndex.value > 2 ? (currentIndex.value - 1) : currentIndex.value,
      duration: Duration(milliseconds: duration),
      curve: Curves.ease,
    );
  }
}