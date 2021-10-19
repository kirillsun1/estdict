import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word/word_validation_errors.dart';

enum ModifyWordStatus { IN_PROGRESS, LOADING, DONE }

class ModifyWordState {
  final PartOfSpeech partOfSpeech;
  final Map<WordFormType, String> forms;
  final List<String?> usages;
  final WordValidationErrors? errors;
  final ModifyWordStatus status;

  ModifyWordState(
      {required this.partOfSpeech,
      required this.forms,
      required this.usages,
      this.status = ModifyWordStatus.IN_PROGRESS,
      this.errors});

  ModifyWordState.newWord(this.partOfSpeech)
      : forms = {},
        usages = [],
        status = ModifyWordStatus.IN_PROGRESS,
        errors = null;
}
