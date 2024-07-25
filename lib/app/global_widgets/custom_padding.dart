import 'package:flutter/material.dart';

class CustomPadding extends StatelessWidget {
  const CustomPadding(this.size, {super.key, this.isWidth = false});
  final double size;
  final bool isWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isWidth ? 0 : size,
      width: isWidth ? size : 0,
    );
  }
}
