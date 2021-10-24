import 'package:estdict/domain/word/part_of_speech.dart';
import 'package:estdict/domain/word/word_form_type.dart';

class Word {
  final int? id;
  final PartOfSpeech partOfSpeech;
  final Map<WordFormType, String> forms;
  final List<String> usages;

  Word(this.partOfSpeech, this.forms, [this.usages = const []]) : id = null;

  Word.withId(int id, this.partOfSpeech, this.forms, [this.usages = const []])
      : id = id;

  @override
  String toString() {
    return 'Word{partOfSpeech: $partOfSpeech, forms: $forms, usages: $usages}';
  }
}
