import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx/app/core/app_colors.dart';
import 'package:getx/app/global_widgets/app_text_button.dart';
import 'package:getx/app/global_widgets/custom_edittext.dart';
import 'package:getx/app/modules/signIn/controller/sign_in_controller.dart';
import 'package:getx/app/routes/routes.dart';

import '../../core/app_icons.dart';
import '../../core/app_sizes.dart';
import '../../global_widgets/custom_image.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.pageBackground2,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.pageBackground2,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: getWidth(90)),
              sliver: const SliverToBoxAdapter(
                child: CustomImage(
                  path: AppIcons.logoText,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  vertical: getWidth(0), horizontal: getWidth(20)),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black, fontSize: getWidth(24)),
                    ),
                    SizedBox(
                      height: getWidth(50),
                    ),
                    CustomEditText().figmaTextField(
                      controller.emailController,
                      "Email",
                      TextInputType.text,
                      height: 60,
                      prefixIcon: CustomImage(
                        path: AppIcons.email,
                        height: getWidth(18),
                        width: getWidth(22),
                      ),
                      inputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: getWidth(16),
                    ),
                    Obx(() {
                      return CustomEditText().figmaTextPasswordField(
                        controller.passwordController,
                        "Password",
                        TextInputType.visiblePassword,
                            (toggle) {
                          controller.toggle(toggle);
                        },
                        isVisible: controller.toggle.value,
                        height: 60,
                        prefixIcon: CustomImage(
                          path: AppIcons.password,
                          height: getWidth(22),
                          width: getWidth(22),
                        ),
                        inputAction: TextInputAction.done,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppTextButton(
                        onTap: (){},
                        text: "Forgot Password",
                        textColor: const Color(0xffA4A9AF),
                        textSize: 13,
                        textDecoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: getWidth(50),),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      height: getWidth(61),
                      width: screenWidth(),
                      child: Obx(() {
                        if(controller.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                            onPressed: (){
                              controller.validationForm(context);
                            },
                            child: Text("Login",style: TextStyle(color: Colors.white,fontSize: getWidth(17),fontWeight: FontWeight.w500),));
                      }
                      ),
                    ),

                    const SizedBox(height: 50,),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: getWidth(56),
                          width: getWidth(56),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(getWidth(16)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    offset: const Offset(0,3),
                                    color: const Color(0xff395AB8).withOpacity(0.1)
                                )
                              ]
                          ),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(getWidth(16)),
                            child: InkWell(
                              onTap: (){},
                              borderRadius: BorderRadius.circular(getWidth(16)),
                              child: const Center(
                                child: CustomImage(
                                  path: AppIcons.facebook,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: getWidth(56),
                          width: getWidth(56),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(getWidth(16)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    offset: const Offset(0,3),
                                    color: const Color(0xff395AB8).withOpacity(0.1)
                                )
                              ]
                          ),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(getWidth(16)),
                            child: InkWell(
                              onTap: (){},
                              borderRadius: BorderRadius.circular(getWidth(16)),
                              child: const Center(
                                child: CustomImage(
                                  path: AppIcons.googleSmall,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50,),
                    Align(
                      alignment: Alignment.center,
                      child: AppTextButton(
                        onTap: (){
                          Get.toNamed(Routes.signup);
                        },
                        text: "Create New Account",
                        textColor: const Color(0xffA4A9AF),
                        textSize: 17,
                        textDecoration: TextDecoration.none,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
