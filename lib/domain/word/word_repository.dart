import 'dart:async';

import 'package:drift/drift.dart';
import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word/word_database.dart' as Db;

enum WordRepositoryEvent { WORD_ADDED, WORD_CHANGED }

class WordsQuery {
  final int maxResults;

  WordsQuery({this.maxResults = 10});
}

class WordRepository {
  final Db.WordDatabase _database;
  final WordValidator _validator;
  final _controller = StreamController<WordRepositoryEvent>();

  WordRepository(
      {Db.WordDatabase? database,
      WordValidator validator = const WordValidator()})
      : _database = database ?? Db.WordDatabase(),
        _validator = validator;

  Stream<WordRepositoryEvent> get events async* {
    yield* _controller.stream;
  }

  Future<List<Word>> findWords(WordsQuery wordsQuery) async {
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

  List<Word> _createWords(List<TypedResult> rows) {
    List<int> ids = [];
    Map<int, PartOfSpeech> partsOfSpeech = {};
    Map<int, Map<WordFormType, String>> forms = {};
    Map<int, Set<String>> usages = {};
    for (var row in rows) {
      var dbWord = row.readTable(_database.words);
      var dbForm = row.readTable(_database.wordForms);
      var dbUsage = row.readTableOrNull(_database.usages);
      final wordId = dbWord.id;

      if (!partsOfSpeech.containsKey(wordId)) {
        ids.add(dbWord.id);
        partsOfSpeech[wordId] = find(PartOfSpeech.values, dbWord.partOfSpeech);

        forms[wordId] = {};
        usages[wordId] = {};
      }

      final wordFormType = find(WordFormType.values, dbForm.formType);
      (forms[wordId]!)[wordFormType] = dbForm.value;
      if (dbUsage != null) {
        usages[wordId]?.add(dbUsage.value);
      }
    }

    return ids
        .map((id) =>
            Word(id, partsOfSpeech[id]!, forms[id]!, usages[id]!.toList()))
        .toList();
  }

  save(Word word) async {
    final errors = _validator.validate(word);
    if (errors != null) {
      throw Exception("Word is invalid");
    }

    await _database.transaction(() async {
      final int wordId;
      if (word.id != null) {
        _database.delete(_database.wordForms)
          ..where((dbWord) => dbWord.wordId.equals(word.id))
          ..go();

        _database.delete(_database.usages)
          ..where((dbUsage) => dbUsage.wordId.equals(word.id))
          ..go();

        wordId = word.id!;
      } else {
        wordId = await _database.into(_database.words).insert(Db.WordsCompanion(
            partOfSpeech: Value(_normalizeEnumName(word.partOfSpeech))));
      }

      await _database.batch((batch) {
        batch.insertAll(
            _database.wordForms,
            word.forms.entries
                .map((entry) => Db.WordForm(
                    formType: _normalizeEnumName(entry.key),
                    value: entry.value,
                    wordId: wordId))
                .toList());

        batch.insertAll(
            _database.usages,
            word.usages
                .map((value) => Db.Usage(value: value, wordId: wordId))
                .toList());
      });
    });
    _controller.add(word.id == null
        ? WordRepositoryEvent.WORD_ADDED
        : WordRepositoryEvent.WORD_CHANGED);
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
