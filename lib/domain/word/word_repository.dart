import 'dart:async';

import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word/part_of_speech.dart';
import 'package:estdict/domain/word/word_form.dart';

final List<Word> _words = [
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

class WordRepository {
  Future<List<Word>> getLatestWords() {
    return Future.delayed(Duration(seconds: 5), () => _words);
  }
}
