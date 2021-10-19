import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/domain/word.dart';

Word createWord(ModifyWordState state) {
  return Word(state.partOfSpeech, _createForms(state.forms),
      _createUsages(state.usages));
}

List<String> _createUsages(List<String?> usages) {
  return usages.whereType<String>().toList();
}

List<WordForm> _createForms(Map<WordFormType, String> forms) {
  return forms.entries
      .where((e) => e.value.trim().isNotEmpty)
      .map((e) => WordForm(e.key, _normalizeValue(e.value)))
      .toList();
}

String _normalizeValue(String value) {
  return value.trim();
}
