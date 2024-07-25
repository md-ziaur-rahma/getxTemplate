import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/dimension.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer(
      {super.key, required this.height, this.width, this.child});

  final double height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.07),
      highlightColor: Colors.grey.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius:
                BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT)),
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
