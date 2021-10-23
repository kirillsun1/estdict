import 'dart:async';

import 'package:drift/drift.dart';
import 'package:estdict/domain/word.dart' as WordDomain;
import 'package:estdict/domain/word/word_database.dart';

enum WordRepositoryEvent { WORD_ADDED }

class WordsQuery {
  final int maxResults;

  WordsQuery({this.maxResults = 10});
}

class WordRepository {
  final WordDatabase _database;
  final WordDomain.WordValidator _validator;

  /*
  TODO: better solution?
  We need to notify blocs when the repository has been changed.
   */
  final _controller = StreamController<WordRepositoryEvent>();

  WordRepository(
      {WordDatabase? database,
      WordDomain.WordValidator validator = const WordDomain.WordValidator()})
      : _database = database ?? WordDatabase(),
        _validator = validator;

  Stream<WordRepositoryEvent> get events async* {
    yield* _controller.stream;
  }

  Future<List<WordDomain.Word>> findWords(WordsQuery wordsQuery) async {
    final rows = await _database.transaction(() async {
      final wordsDbQuery = _database.selectOnly(_database.words)
        ..addColumns([_database.words.id])
        ..orderBy([OrderingTerm.desc(_database.words.createdAt)])
        ..limit(wordsQuery.maxResults);

      final words = await wordsDbQuery.get();
      final wordsIds = words.map((e) => e.read(_database.words.id));

      final allDataDbQuery = _database.select(_database.words).join([
        innerJoin(_database.wordForms,
            _database.wordForms.wordId.equalsExp(_database.words.id)),
        leftOuterJoin(_database.usages,
            _database.usages.wordId.equalsExp(_database.words.id))
      ])
        ..where(_database.words.id.isIn(wordsIds))
        ..orderBy([OrderingTerm.desc(_database.words.createdAt)]);

      return await allDataDbQuery.get();
    });
    return Future.value(_createWords(rows));
  }

  List<WordDomain.Word> _createWords(List<TypedResult> rows) {
    List<int> ids = [];
    Map<int, WordDomain.PartOfSpeech> partsOfSpeech = {};
    Map<int, Map<WordDomain.WordFormType, String>> forms = {};
    Map<int, Set<String>> usages = {};
    for (var row in rows) {
      var dbWord = row.readTable(_database.words);
      var dbForm = row.readTable(_database.wordForms);
      var dbUsage = row.readTableOrNull(_database.usages);
      final wordId = dbWord.id;

      if (!partsOfSpeech.containsKey(wordId)) {
        ids.add(dbWord.id);
        partsOfSpeech[wordId] =
            find(WordDomain.PartOfSpeech.values, dbWord.partOfSpeech);

        forms[wordId] = {};
        usages[wordId] = {};
      }

      final wordFormType =
          find(WordDomain.WordFormType.values, dbForm.formType);
      (forms[wordId]!)[wordFormType] = dbForm.value;
      if (dbUsage != null) {
        usages[wordId]?.add(dbUsage.value);
      }
    }

    return ids
        .map((id) => WordDomain.Word.withId(
            id,
            partsOfSpeech[id]!,
            forms[id]!
                .entries
                .map((e) => WordDomain.WordForm(e.key, e.value))
                .toList(),
            usages[id]!.toList()))
        .toList();
  }

  save(WordDomain.Word word) async {
    final errors = _validator.validate(word);
    if (errors != null) {
      throw Exception("Word is invalid");
    }

    await _database.transaction(() async {
      final wordId = await _database.into(_database.words).insert(
          WordsCompanion(
              partOfSpeech: Value(_normalizeEnumName(word.partOfSpeech))));

      await _database.batch((batch) {
        batch.insertAll(
            _database.wordForms,
            word.forms
                .map((form) => WordForm(
                    formType: _normalizeEnumName(form.formType),
                    value: form.value,
                    wordId: wordId))
                .toList());

        batch.insertAll(
            _database.usages,
            word.usages
                .map((value) => Usage(value: value, wordId: wordId))
                .toList());
      });
    });
    _controller.add(WordRepositoryEvent.WORD_ADDED);
  }

  void dispose() {
    _controller.close();
  }
}

T find<T extends Enum>(Iterable<T> values, String value) {
  return values.where((type) => _normalizeEnumName(type) == value).first;
}

String _normalizeEnumName<T extends Enum>(T value) {
  return value.toString().split(".").last;
}
