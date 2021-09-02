import 'package:estdict/components/card/word_overview.dart';
import 'package:estdict/components/layout/background.dart';
import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';

final List<Word> words = [
  Word(WordType.NOUN, [
    WordForm(WordFormType.EST_NIMETAV, "kasutama"),
    WordForm(WordFormType.RUS_INF, "юзать"),
  ]),
  Word(WordType.ADJECTIVE, [
    WordForm(WordFormType.EST_NIMETAV, "ilus"),
    WordForm(WordFormType.RUS_INF, "красивый"),
  ]),
  Word(WordType.VERB, [
    WordForm(WordFormType.EST_MA_INF, "tegema"),
    WordForm(WordFormType.RUS_INF, "делать"),
  ]),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            createWelcomeBar(),
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            createNewWordBar(),
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            createLastAddedWords(words)
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
    padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
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

Widget createLastAddedWords(List<Word> words) {
  return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    'Here is what you learned previously:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [...words.map((word) => WordOverview(word: word))],
                )
              ],
            ),
          )
        ],
      ));
}

Widget createNewWordBar() {
  return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Chip(label: Text('Noun')),
                    SizedBox(
                      width: 5,
                    ),
                    Chip(label: Text('Verb')),
                    SizedBox(
                      width: 5,
                    ),
                    Chip(label: Text('Adjective'))
                  ],
                ),
              )
            ],
          ))
        ],
      ));
}
