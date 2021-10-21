import 'package:collection/collection.dart';
import 'package:estdict/domain/word/part_of_speech.dart';
import 'package:estdict/domain/word/word_form.dart';

class Word {
  final int? id;
  final PartOfSpeech partOfSpeech;
  final List<WordForm> forms;
  final List<String> usages;

  Word(this.partOfSpeech, this.forms, [this.usages = const []]) : id = null;

  Word.withId(int id, this.partOfSpeech, this.forms, [this.usages = const []])
      : id = id;

  String? findFormValue(WordFormType formType) {
    return this
        .forms
        .firstWhereIndexedOrNull((i, e) => e.formType == formType)
        ?.value;
  }

  @override
  String toString() {
    var formsString =
        "[${forms.map((e) => "${e.formType} -> ${e.value}").join(", ")}]";
    return 'Word{partOfSpeech: $partOfSpeech, forms: $formsString, usages: $usages}';
  }
}
