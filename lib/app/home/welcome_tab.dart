import 'package:flutter/material.dart';

import 'background.dart';
import 'create_word_buttons.dart';
import 'last_added_words.dart';
import 'welcome_bar.dart';

class WelcomeTab extends StatelessWidget {
  const WelcomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          SizedBox(
            height: 30,
          ),
          WelcomeBar(),
          SizedBox(
            height: 30,
          ),
          LastAddedWords(),
          SizedBox(
            height: 30,
          ),
          CreateWordButtons()
        ],
      ),
    );
  }
}
