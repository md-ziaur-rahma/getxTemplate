import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_colors.dart';
import '../../core/app_sizes.dart';
import 'controller/language_controller.dart';

class SelectLanguage extends GetView<LanguageController> {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: context.isDarkMode ? Colors.grey[900] : Colors.white,
        title: Text(
          "language".tr,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getHeight(16),
              color: context.isDarkMode ? Colors.white : Colors.black,
              letterSpacing: 0.7),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getHeight(15)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: getHeight(40),
                ),
                Text(
                  "select_language".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: getHeight(24)),
                ),
                Text(
                  "select_prefer_langugae".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: getHeight(16)),
                ),
                SizedBox(
                  height: getHeight(40),
                ),
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.langaugeList.length,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.1,
                        mainAxisSpacing: getHeight(20),
                        crossAxisSpacing: getHeight(20)),
                    itemBuilder: (context, index) {
                      var item = controller.langaugeList[index];
                      return InkWell(
                        onTap: () {
                          controller.selectedCode.value = item.id;
                          controller.local.value =
                              Locale(item.languageCode, item.countryCode);
                        },
                        borderRadius: BorderRadius.circular(getHeight(10)),
                        child: Obx(() => Container(
                              decoration: BoxDecoration(
                                  color:
                                      controller.selectedCode.value == item.id
                                          ? context.isDarkMode
                                              ? Colors.grey[800]
                                              : AppColors.deppBlue
                                          : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(getHeight(10)),
                                  border:
                                      Border.all(color: AppColors.greyColor)),
                              child: Center(
                                  child: Text(
                                item.lanugaeName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                    fontSize: getHeight(18),
                                    color:
                                        controller.selectedCode.value == item.id
                                            ? Colors.white
                                            : context.isDarkMode
                                                ? Colors.white
                                                : Colors.black),
                              )),
                            )),
                      );
                    })
              ]),
        ),
      ),
      floatingActionButton: TextButton.icon(
        onPressed: () {
          if (controller.isLoading.value == false) {
            controller.setLanguage();
          }
        },
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        label: Obx(
          () => Text(
            controller.isLoading.value ? "Loading.." : "continue".tr,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: getHeight(17)),
          ),
        ),
        style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.white.withOpacity(0.2)),
            padding: MaterialStateProperty.resolveWith((states) =>
                EdgeInsets.symmetric(
                    horizontal: getHeight(15), vertical: getHeight(14))),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => AppColors.deppBlue)),
      ),
    );
  }
}