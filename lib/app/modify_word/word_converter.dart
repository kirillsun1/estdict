import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/domain/word.dart';

Word createWord(ModifyWordState state) {
  return Word(state.id, state.partOfSpeech, _createForms(state.forms),
      _createUsages(state.usages));
}

List<String> _createUsages(List<String?> usages) {
  return usages.whereType<String>().toList();
}

Map<WordFormType, String> _createForms(Map<WordFormType, String> forms) {
  return Map.fromEntries(forms.entries
      .where((e) => e.value.trim().isNotEmpty)
      .map((e) => MapEntry(e.key, _normalizeValue(e.value))));
}

String _normalizeValue(String value) {
  return value.trim();
}
