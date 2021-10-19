import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/domain/word_configuration/word_forms_configuration.dart';

class ModifyWordStateValidator {
  const ModifyWordStateValidator();

  ValidationErrors? validate(ModifyWordState state) {
    var errors = Set<String>();
    if (_isInfinitiveMissing(state)) errors.add("missingInfinitive");
    errors.addAll(_validateForms(state));
    errors.addAll(_validateUsages(state));
    return errors.isEmpty ? null : ValidationErrors(errors);
  }

  bool _isInfinitiveMissing(ModifyWordState state) {
    final infinitives =
        state.partOfSpeech.groupedForms.map((e) => e.infinitive).toSet();
    final usedForms = state.forms.keys.toSet();
    return infinitives.intersection(usedForms).isEmpty;
  }

  Iterable<String> _validateForms(ModifyWordState state) {
    return state.forms.entries
        .where((element) => _isBlank(element.value))
        .map((e) => "field__${e.key}");
  }

  Iterable<String> _validateUsages(ModifyWordState state) {
    var usages = state.usages;
    return List<int>.generate(usages.length, (i) => i)
        // null in list is okay, it will be filtered out later on
        .where((i) => usages[i] != null && _isBlank(usages[i]!))
        .map((i) => "usage__$i");
  }

  bool _isBlank(String value) {
    return value.trim().isEmpty;
  }
}
