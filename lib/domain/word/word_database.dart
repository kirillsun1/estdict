import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'word_database.g.dart';

class Words extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get partOfSpeech => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class WordForms extends Table {
  TextColumn get formType => text()();

  TextColumn get value => text()();

  IntColumn get wordId =>
      integer().customConstraint("NOT NULL REFERENCES word(id)")();

  @override
  Set<Column> get primaryKey => {wordId, formType};
}

class Usages extends Table {
  TextColumn get value => text()();

  IntColumn get wordId =>
      integer().customConstraint("NOT NULL REFERENCES word(id)")();

  @override
  Set<Column> get primaryKey => {wordId, value};
}

@DriftDatabase(tables: [Words, WordForms, Usages])
class WordDatabase extends _$WordDatabase {
  WordDatabase() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}

// copied from drift example
// https://drift.simonbinder.eu/docs/getting-started/
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
