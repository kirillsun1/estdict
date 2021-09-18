import 'package:collection/collection.dart';
import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/part_of_speech.dart';

class Word {
  final PartOfSpeech partOfSpeech;
  final List<WordForm> forms;
  final List<String> usages;

  Word(this.partOfSpeech, this.forms, [this.usages = const []]);

  String? findFormValue(WordFormType formType) {
    return this
        .forms
        .firstWhereIndexedOrNull((i, e) => e.formType == formType)
        ?.value;
  }
}
