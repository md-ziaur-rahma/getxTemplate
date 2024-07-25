import 'package:getx/app/core/app_colors.dart';
import 'package:getx/app/core/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final double? borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final bool filled;
  final Color? fillColor;
  final Color? borderColor;
  final double? width;
  final double? contentPadding;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool? isEnabled;
  final bool isReadOnly;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Color? hintColor;
  final Color? textColor;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? suffixIcon;
  final bool? obsecure;
  final bool isShadow;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final bool isSuffixIconConstrained;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;
  final double? scrollPadding;
  final bool readOnly;

  const RoundedInputField(
      {Key? key,
      required this.hintText,
      this.icon,
      this.scrollPadding,
      this.borderRadius = 10.0,
      this.paddingVertical = 16,
      this.paddingHorizontal = 16.0,
      this.fontSize = 15,
      this.fontWeight = FontWeight.w400,
      this.fontFamily = Constants.quicksandFont,
      this.filled = true,
      this.fillColor,
      this.borderColor,
      this.width,
      this.contentPadding,
      this.onChanged,
      this.onTap,
      this.controller,
      this.isEnabled,
      this.isReadOnly = false,
      this.inputType,
      this.inputAction,
      this.hintColor,
      this.textColor,
      this.inputFormatter,
      this.suffixIcon,
      this.obsecure,
      this.isShadow = false,
      this.shadowColor,
      this.shadowOffset,
      this.textAlign,
      this.isSuffixIconConstrained = false,
      this.maxLines,
      this.focusNode,
      this.maxLength,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isShadow
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              boxShadow: [
                BoxShadow(
                  color: shadowColor ?? Colors.black.withOpacity(0.25),
                  spreadRadius: 0.1,
                  blurRadius: 4,
                  offset: shadowOffset ?? const Offset(0, 0),
                ),
              ],
            )
          : borderColor != null
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius ?? 10),
                  border: Border.all(color: borderColor!))
              : const BoxDecoration(),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        keyboardType: inputType,
        focusNode: focusNode,
        maxLines: maxLines ?? 1,
        onChanged: onChanged,
        scrollPadding: scrollPadding != null
            ? EdgeInsets.only(bottom: scrollPadding ?? 40)
            : EdgeInsets.zero,
        textAlign: textAlign ?? TextAlign.start,
        obscureText: obsecure ?? false,
        inputFormatters: inputFormatter,
        maxLength: maxLength,
        style: TextStyle(color: textColor),
        textInputAction: inputAction ?? TextInputAction.done,
        decoration: InputDecoration(
          hintText: hintText,
          counterText: "",
          filled: filled,
          contentPadding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          fillColor: fillColor ?? Colors.white.withOpacity(0.5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: BorderSide.none),
          hintStyle: TextStyle(
              color: hintColor ?? AppColors.boldTextColor,
              fontSize: fontSize,
              fontFamily: Constants.quicksandFont,
              fontWeight: fontWeight),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
