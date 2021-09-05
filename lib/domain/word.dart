import 'package:collection/collection.dart';
import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/word_type.dart';

class Word {
  final WordType wordType;
  final List<WordForm> forms;
  final List<String> usages;

  Word(this.wordType, this.forms, [this.usages = const []]);

  String? findFormValue(WordFormType formType) {
    return this
        .forms
        .firstWhereIndexedOrNull((i, e) => e.formType == formType)
        ?.value;
  }
}
