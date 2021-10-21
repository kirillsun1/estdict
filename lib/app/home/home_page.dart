import 'package:estdict/app/home/background.dart';
import 'package:estdict/app/home/home_page_bloc.dart';
import 'package:estdict/app/home/welcome_bar.dart';
import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_word_buttons.dart';
import 'last_added_words.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            HomePageBloc(context.read<WordRepository>())..add(WordsRequested()),
        child: _HomePageView());
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
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
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: "Find word")
          ],
        ),
      ),
    );
  }
}
