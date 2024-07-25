import 'package:flutter/material.dart';
import 'package:getx/app/global_widgets/custom_image.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({super.key, required this.icon, required this.onPressed, required this.isActive});
  final String icon;
  final Function onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: (){
              onPressed();
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CustomImage(path: icon,color: isActive ? const Color(0xffFF679B) : const Color(0xff6E7FAA),),
            ),
          ),
        ),
      ),
    );
  }
}
