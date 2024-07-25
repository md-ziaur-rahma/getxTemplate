import 'package:getx/app/core/app_colors.dart';
import 'package:getx/app/core/contants.dart';
import 'package:flutter/material.dart';

class NormalAppBar extends StatelessWidget {
  NormalAppBar(
      {super.key,
      required this.title,
      required this.onPressed,
      this.color,
      this.textAlign});
  final String title;
  final Function onPressed;
  Color? color;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          child: IconButton(
            onPressed: () {
              onPressed();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: color ?? AppColors.boldTextColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: color,
                  fontFamily: Constants.nunito,
                  fontSize: 20,
                  letterSpacing: -0.4,
                  fontWeight: FontWeight.w700),
              textAlign: textAlign ?? TextAlign.center,
            ),
          ),
        )
        // HelperText().titleText(title,color: color ?? textColor),
      ],
    );
  }
}
