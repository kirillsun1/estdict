import 'package:estdict/app/home/background.dart';
import 'package:estdict/app/home/home_page_bloc.dart';
import 'package:estdict/app/modify_word/create_word_page.dart';
import 'package:estdict/app/word/word_overview.dart';
import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              height: 20,
            ),
            createWelcomeBar(),
            SizedBox(
              height: 30,
            ),
            LastAddedWords(),
            SizedBox(
              height: 30,
            ),
            createNewWordBar()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: "Find word"),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_rounded), label: "Words to add")
          ],
        ),
      ),
    );
  }
}

Widget createWelcomeBar() {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 24, right: 24),
    child: Text(
      'Welcome to EST Dictionary',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
  );
}

class LastAddedWords extends StatelessWidget {
  const LastAddedWords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) => Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.loading)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()],
                        )
                      else ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Text(
                            'Here is what you learned previously:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            children: [
                              ...state.words
                                  .map((word) => WordOverview(word: word))
                            ],
                          ),
                        )
                      ]
                    ],
                  ),
                )
              ],
            )));
  }
}

Widget createNewWordBar() {
  var wordTypes = PartOfSpeech.values;
  return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add a new word',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5,
                  ),
                  itemCount: wordTypes.length,
                  itemBuilder: (context, index) => ActionChip(
                      label: Text(wordTypes[index].name),
                      onPressed: () =>
                          openWordCreationDialog(context, wordTypes[index])),
                ),
              )
            ],
          ))
        ],
      ));
}

void openWordCreationDialog(BuildContext context, PartOfSpeech wordType) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateWordPage(partOfSpeech: wordType)));
}
