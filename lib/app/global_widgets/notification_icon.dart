import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.toNamed(Routes.notificationScreen);
      },
      icon: Badge(
        label: Obx(() => const Text(
            "5")),
        child: const Icon(
          FontAwesomeIcons.bell,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
