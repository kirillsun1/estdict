import 'package:collection/collection.dart';

enum WordType { NOUN, ADJECTIVE, VERB }

class Word {
  final WordType wordType;
  final List<WordForm> forms;
  final List<String> usages;

  Word(this.wordType, this.forms, [this.usages = const []]);

  String get mainEstonianForm {
    return this._findFormValue(_getMainEstonianForm(this.wordType));
  }

  String get mainRussianForm {
    return this._findFormValue(WordFormType.RUS_INF);
  }

  String _findFormValue(WordFormType formType) {
    WordForm? form =
        this.forms.firstWhereIndexedOrNull((i, e) => e.formType == formType);
    if (form == null) {
      throw Exception("Word doesn't have required form. Needed: " +
          formType.toString() +
          ". Other forms: " +
          this.forms.toString());
    }
    return form.value;
  }
}

enum WordFormType {
  EST_NIMETAV,
  EST_MA_INF,
  RUS_INF,
}

class WordForm {
  final WordFormType formType;
  final String value;

  WordForm(this.formType, this.value);
}

WordFormType _getMainEstonianForm(WordType wordType) {
  if (wordType == WordType.NOUN || wordType == WordType.ADJECTIVE) {
    return WordFormType.EST_NIMETAV;
  }
  if (wordType == WordType.VERB) {
    return WordFormType.EST_MA_INF;
  }
  throw StateError("No Main Estonian Form defined for " + wordType.toString());
}
