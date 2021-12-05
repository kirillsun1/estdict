import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_bloc.dart';
import 'search_words_tab.dart';
import 'welcome_tab.dart';

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

class _HomePageView extends StatefulWidget {
  const _HomePageView({Key? key}) : super(key: key);

  @override
  State<_HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<_HomePageView> {
  static const List<Widget> _tabs = [WelcomeTab(), SearchWordsTab()];
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (value) => setState(() {
          _currentPageIndex = value;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "All")
        ],
      ),
    );
  }
}
