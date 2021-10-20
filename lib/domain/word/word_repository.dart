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

enum WordRepositoryEvent { WORD_ADDED }

class WordRepository {
  final List<Word> _cachedWords = List.of(_words);

  /*
  TODO: better solution?
  We need to notify blocs when the repository has been changed.
   */
  final _controller = StreamController<WordRepositoryEvent>();

  Stream<WordRepositoryEvent> get events async* {
    yield* _controller.stream;
  }

  Future<List<Word>> getLatestWords() {
    return Future.value(_cachedWords);
  }

  save(Word word) async {
    _cachedWords.insert(0, word);
    _controller.add(WordRepositoryEvent.WORD_ADDED);
  }

  void dispose() {
    _controller.close();
  }
}
