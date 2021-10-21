import 'package:flutter/material.dart';

class HomePageBlock extends StatelessWidget {
  final Widget child;
  final bool narrow;

  const HomePageBlock({Key? key, required this.child, this.narrow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: horizontalPaddingValue, right: horizontalPaddingValue),
      child: child,
    );
  }

  double get horizontalPaddingValue {
    return narrow ? 8 : 24;
  }
}
