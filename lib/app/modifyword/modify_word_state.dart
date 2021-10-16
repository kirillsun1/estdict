import 'package:estdict/domain/part_of_speech.dart';
import 'package:estdict/domain/word_form.dart';

class ModifyWordState {
  final PartOfSpeech partOfSpeech;
  final Map<WordFormType, String> forms;

  ModifyWordState(this.partOfSpeech, this.forms);

  ModifyWordState.newWord(this.partOfSpeech) : forms = {};
}
