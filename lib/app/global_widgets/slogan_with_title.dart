import 'package:flutter/material.dart';

import '../core/app_sizes.dart';
import '../core/dimension.dart';

class SloganWithTitle extends StatefulWidget {
  const SloganWithTitle(
      {super.key,
      required this.slogan,
      required this.title,
      required this.onTap,
      this.alignment});

  final String slogan;
  final String title;
  final Function() onTap;
  final WrapAlignment? alignment;

  @override
  State<SloganWithTitle> createState() => _SloganWithTitleState();
}

class _SloganWithTitleState extends State<SloganWithTitle> {
  void _onTapDown(TapDownDetails details) {
    Future.delayed(const Duration(milliseconds: 0)).then((value) {
      setState(() {
        isTap = true;
      });
    });
  }

  void _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      setState(() {
        isTap = false;
      });
    });
  }

  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: widget.alignment ?? WrapAlignment.center,
        spacing: 0,
        children: <Widget>[
          Text(
            widget.slogan,
            style: TextStyle(
                fontSize: getWidth(Dimensions.mText),
                fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: widget.onTap,
            onTapUp: _onTapUp,
            onTapDown: _onTapDown,
            child: Text(
              widget.title,
              style: TextStyle(
                  color: isTap ? Colors.blue : Colors.black,
                  fontSize: getWidth(Dimensions.mText),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
