import 'package:estdict/domain/word.dart';

class ValidationErrors {
  final Set<String> _fields;

  ValidationErrors(this._fields);

  bool isMissingInfinitive() {
    return _isInvalid("missingInfinitive");
  }

  bool isFieldInvalid(WordFormType field) {
    return _isInvalid("field__$field");
  }

  bool isUsageInvalid(int index) {
    return _isInvalid("usage__$index");
  }

  bool _isInvalid(String key) {
    return _fields.contains(key);
  }
}

enum ModifyWordStatus { IN_PROGRESS, LOADING, DONE }

class ModifyWordState {
  final PartOfSpeech partOfSpeech;
  final Map<WordFormType, String> forms;
  final List<String?> usages;
  final ValidationErrors? errors;
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
