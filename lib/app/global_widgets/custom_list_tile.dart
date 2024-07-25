import 'package:flutter/material.dart';
import '../core/app_sizes.dart';
import '../core/contants.dart';
import '../core/dimension.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      this.onTap,
      required this.title,
      this.leadingImage,
      this.leadingWidget,
      this.trailing,
      this.fontSize,
      this.subTitle,
      this.horizonPadding,
      this.leadingWidth});

  final Function()? onTap;
  final String? leadingImage;
  final Widget? leadingWidget;
  final String title;
  final Widget? trailing;
  final double? fontSize;
  final double? horizonPadding;
  final double? leadingWidth;
  final Widget? subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 0,
      splashColor: Colors.transparent,
      contentPadding:
          EdgeInsets.symmetric(horizontal: getWidth(horizonPadding ?? 0)),
      minLeadingWidth: leadingWidget == null && leadingImage == null
          ? 0
          : getWidth(leadingWidth ?? 35),
      leading: leadingImage != null
          ? Image.asset(
              leadingImage!,
              height: getWidth(45),
              width: getWidth(45),
            )
          : leadingWidget ?? const SizedBox(),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: Constants.quicksandFont,
            fontWeight: FontWeight.w600,
            fontSize: fontSize ?? getWidth(Dimensions.mText)),
      ),
      subtitle: subTitle,
      trailing: trailing,
    );
  }
}
