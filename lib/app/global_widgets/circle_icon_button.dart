import 'package:getx/app/core/app_colors.dart';
import 'package:flutter/material.dart';

import 'custom_image.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton(
      {super.key,
      this.onTap,
      required this.icon,
      this.height = 34.0,
      this.width = 34.0,
      this.iconSize = 17.0,
      this.buttonColor,
      this.isSvg = true});
  final Function()? onTap;
  final double height, width;
  final Color? buttonColor;
  final String icon;
  final double iconSize;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        type: MaterialType.circle,
        color: Colors.white,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: buttonColor ?? AppColors.red.withOpacity(0.12)),
          child: Center(
            child: isSvg
                ? CustomImage(path: icon, height: iconSize, width: iconSize)
                : Image.asset(
                    icon,
                    height: iconSize,
                    width: iconSize,
                  ),
          ),
        ),
      ),
    );
  }
}
