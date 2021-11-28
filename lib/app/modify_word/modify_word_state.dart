import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word/word_validation_errors.dart';

enum ModifyWordStatus { IN_PROGRESS, LOADING, DONE }

class ModifyWordState {
  final int? id;
  final PartOfSpeech partOfSpeech;
  final Map<WordFormType, String> forms;
  final List<String?> usages;
  final WordValidationErrors? errors;
  final ModifyWordStatus status;

  ModifyWordState(
      {required this.partOfSpeech,
      required this.forms,
      required this.usages,
      this.id,
      this.status = ModifyWordStatus.IN_PROGRESS,
      this.errors});

  ModifyWordState.newWord(this.partOfSpeech)
      : id = null,
        forms = {},
        usages = [],
        status = ModifyWordStatus.IN_PROGRESS,
        errors = null;

  ModifyWordState.existingWord(Word word)
      : id = word.id,
        forms = word.forms,
        usages = word.usages,
        partOfSpeech = word.partOfSpeech,
        status = ModifyWordStatus.IN_PROGRESS,
        errors = null;

  bool get isEditMode {
    return this.id != null;
  }
}
