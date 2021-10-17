import 'package:bloc/bloc.dart';
import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/domain/word_form.dart';

abstract class ModifyWordEvent {}

class FormValueModified extends ModifyWordEvent {
  final WordFormType type;
  final String? value;

  FormValueModified(this.type, this.value);
}

class WordFinalized extends ModifyWordEvent {}

class UsageModified extends ModifyWordEvent {
  final int index;
  final String? value;

  UsageModified(this.index, this.value);
}

class ModifyWordBloc extends Bloc<ModifyWordEvent, ModifyWordState> {
  ModifyWordBloc(ModifyWordState state) : super(state) {
    on<FormValueModified>(_onFormValueModified);
    on<WordFinalized>(_onWordFinalized);
    on<UsageModified>(_onUsageModified);
  }

  void _onFormValueModified(
      FormValueModified event, Emitter<ModifyWordState> emit) {
    var forms = Map.of(state.forms);
    if (event.value == null) {
      forms.remove(event.type);
    } else {
      forms[event.type] = event.value!;
    }

    emit(ModifyWordState(
        state.partOfSpeech, Map.unmodifiable(forms), state.usages));
  }

  void _onUsageModified(UsageModified event, Emitter<ModifyWordState> emit) {
    List<String?> modifiableUsages = List.of(state.usages);
    int indexToChange = event.index;
    if (modifiableUsages.length <= event.index) {
      int firstEmpty =
          modifiableUsages.indexWhere((element) => element == null);
      if (firstEmpty == -1) {
        modifiableUsages.length = event.index + 1;
      } else {
        indexToChange = firstEmpty;
      }
    }
    modifiableUsages[indexToChange] = event.value;
    print(modifiableUsages);

    emit(ModifyWordState(
        state.partOfSpeech, state.forms, List.unmodifiable(modifiableUsages)));
  }

  void _onWordFinalized(WordFinalized event, Emitter<ModifyWordState> emit) {
    // TODO: Add Save
  }
}
