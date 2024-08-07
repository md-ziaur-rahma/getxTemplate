import 'package:getx/app/core/app_colors.dart';
import 'package:flutter/material.dart';

class PageLoader extends StatelessWidget {
  const PageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: AppColors.mainColor,
        ),
      ),
    );
  }
}
