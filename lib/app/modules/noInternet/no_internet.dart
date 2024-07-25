import 'package:getx/app/core/app_colors.dart';
import 'package:getx/app/core/app_images.dart';
import 'package:getx/app/core/app_sizes.dart';
import 'package:getx/app/modules/noInternet/controller/no_internet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetPage extends GetView<NoInternetController> {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AppImages.noInternet,
              height: getHeight(350),
            ),
            SizedBox(
              height: 10,
              width: AppSizes.width,
            ),
            const Text(
              "Ooops!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Slow or no internet connection\nCheck your internet settings.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.greyColor, fontSize: 14),
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      controller.checkInternet();
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateColor.resolveWith(
                            (states) => AppColors.deppBlue)),
                    child: const Text(
                      "TRY AGAIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8),
                    )))
          ]),
    );
  }
}
