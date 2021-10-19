import 'package:estdict/domain/word/word.dart';
import 'package:estdict/domain/word/word_form.dart';
import 'package:estdict/domain/word/word_validation_errors.dart';
import 'package:estdict/domain/word_configuration/word_forms_configuration.dart';

class WordValidator {
  const WordValidator();

  WordValidationErrors? validate(Word word) {
    var isInfinitiveMissing = _isInfinitiveMissing(word);
    var invalidForms = _validateForms(word);
    var invalidUsages = _validateUsages(word);

    return isInfinitiveMissing ||
            invalidForms.isNotEmpty ||
            invalidUsages.isNotEmpty
        ? WordValidationErrors(isInfinitiveMissing, invalidForms, invalidUsages)
        : null;
  }

  bool _isInfinitiveMissing(Word word) {
    final infinitives =
        word.partOfSpeech.groupedForms.map((e) => e.infinitive).toSet();
    final usedForms = word.forms.map((e) => e.formType).toSet();
    return infinitives.intersection(usedForms).isEmpty;
  }

  Set<WordFormType> _validateForms(Word word) {
    return word.forms
        .where((element) => _isBlank(element.value))
        .map((e) => e.formType)
        .toSet();
  }

  Set<int> _validateUsages(Word word) {
    var usages = word.usages;
    return List<int>.generate(usages.length, (i) => i)
        .where((i) => _isBlank(usages[i]))
        .map((i) => i)
        .toSet();
  }

  bool _isBlank(String value) {
    return value.trim().isEmpty;
  }
}
