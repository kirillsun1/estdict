import 'package:estdict/domain/word.dart';

class WordValidationErrors {
  final bool missingInfinitive;
  final Set<WordFormType> _incorrectForms;
  final Set<int> _incorrectUsages;

  WordValidationErrors(
      this.missingInfinitive, this._incorrectForms, this._incorrectUsages);

  bool isFormInvalid(WordFormType field) {
    return _incorrectForms.contains(field);
  }

  bool isUsageInvalid(int index) {
    return _incorrectUsages.contains(index);
  }
}
