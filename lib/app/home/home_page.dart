import 'package:estdict/app/word/word_overview.dart';
import 'package:estdict/app/home/background.dart';
import 'package:estdict/app/modifyword/create_word_page.dart';
import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/part_of_speech.dart';
import 'package:flutter/material.dart';

final List<Word> words = [
  Word(PartOfSpeech.NOUN, [
    WordForm(WordFormType.EST_INF, "mäng"),
    WordForm(WordFormType.RUS_INF, "игра"),
  ]),
  Word(PartOfSpeech.ADJECTIVE, [
    WordForm(WordFormType.EST_INF, "ilus"),
    WordForm(WordFormType.RUS_INF, "красивый"),
  ]),
  Word(PartOfSpeech.VERB, [
    WordForm(WordFormType.EST_INF, "tegema"),
    WordForm(WordFormType.RUS_INF, "делать"),
  ])
];

class HomePage extends StatelessWidget {
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
            createWelcomeBar(),
            SizedBox(
              height: 20,
            ),
            createLastAddedWords(words),
            SizedBox(
              height: 10,
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
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
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
  var wordTypes = PartOfSpeech.values;
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
