import 'package:estdict/domain/word.dart';

class ModifyWordState {
  final PartOfSpeech partOfSpeech;
  final Map<WordFormType, String> forms;
  final List<String?> usages;

  ModifyWordState(this.partOfSpeech, this.forms, this.usages);

  ModifyWordState.newWord(this.partOfSpeech)
      : forms = {},
        usages = [];
}
