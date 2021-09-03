import 'package:collection/collection.dart';
import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/word_type.dart';

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

WordFormType _getMainEstonianForm(WordType wordType) {
  if (wordType == WordType.NOUN || wordType == WordType.ADJECTIVE) {
    return WordFormType.EST_SINGULAR_FIRST;
  }
  if (wordType == WordType.VERB) {
    return WordFormType.EST_MA_INF;
  }
  throw StateError("No Main Estonian Form defined for " + wordType.toString());
}
