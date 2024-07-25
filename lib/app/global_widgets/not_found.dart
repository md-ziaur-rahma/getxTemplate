import 'package:getx/app/global_widgets/custom_image.dart';
import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const CustomImage(
            path:
                "https://cdni.iconscout.com/illustration/premium/thumb/no-result-search-4064371-3363932.png",
            height: 200,
            width: 200,
          ),
          Positioned(
              bottom: 10,
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
