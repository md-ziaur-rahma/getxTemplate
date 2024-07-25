import 'package:getx/app/core/app_colors.dart';
import 'package:flutter/material.dart';

import '../core/contants.dart';
import '../core/dimension.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon,
      this.color,
      this.fontWeight,
      this.fonstSize = Dimensions.lText,
      this.titleColor,
      this.verticalPadding,
      this.fontFamily = Constants.quicksandFont});
  final String title;
  final String icon;
  final Function() onTap;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fonstSize;
  final double? verticalPadding;
  final Color? titleColor;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
          foregroundColor: Colors.grey,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: color ?? Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 20,
            width: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: titleColor ?? AppColors.boldTextColor,
                fontWeight: fontWeight ?? FontWeight.w600,
                fontFamily: fontFamily,
                fontSize: fonstSize),
          ),
        ],
      ),
    );
  }
}
