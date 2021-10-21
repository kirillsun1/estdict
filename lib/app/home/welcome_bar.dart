import 'package:estdict/app/home/home_page_block.dart';
import 'package:flutter/material.dart';

class WelcomeBar extends StatelessWidget {
  const WelcomeBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageBlock(
        child: Text(
      'Hey there!',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ));
  }
}
