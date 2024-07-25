import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class GradientLinearProgressIndicator extends StatelessWidget {
  final double value;
  final List<Color> gradientColors;

  const GradientLinearProgressIndicator({
    super.key,
    required this.value,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 20,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.linearProgressBackColor.withOpacity(0.35),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: Container(
                height: 20,
                width: constraints.maxWidth * (value / 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Positioned(
              left: constraints.maxWidth * (value / 100) - 20,
              child: Container(
                height: 17,
                width: 17,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 1,
                      height: double.infinity,
                      color:
                          AppColors.linearProgressBackColor.withOpacity(0.35),
                    ),
                    Container(
                      width: 1,
                      height: double.infinity,
                      color:
                          AppColors.linearProgressBackColor.withOpacity(0.35),
                    ),
                    Container(
                      width: 1,
                      height: double.infinity,
                      color:
                          AppColors.linearProgressBackColor.withOpacity(0.35),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
