import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx/app/core/app_colors.dart';
import 'package:getx/app/core/app_icons.dart';
import 'package:getx/app/global_widgets/custom_image.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return Scaffold(
      backgroundColor: AppColors.pageBackground2,
      body: Obx(() {
        if(controller.isLoading.value){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: AnimatedContainer(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 1500),
              child: const CustomImage(path: AppIcons.logoText,)),
        );
      }
      ),
    );
  }
}
