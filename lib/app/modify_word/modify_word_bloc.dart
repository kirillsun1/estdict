import 'package:bloc/bloc.dart';
import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/app/modify_word/word_converter.dart';
import 'package:estdict/domain/word.dart';

import 'modify_word_state_validator.dart';

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
  final ModifyWordStateValidator modifyWordStateValidator;

  ModifyWordBloc(ModifyWordState state,
      [this.modifyWordStateValidator = const ModifyWordStateValidator()])
      : super(state) {
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
        partOfSpeech: state.partOfSpeech,
        forms: Map.unmodifiable(forms),
        usages: state.usages));
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

    emit(ModifyWordState(
        partOfSpeech: state.partOfSpeech,
        forms: state.forms,
        usages: List.unmodifiable(modifiableUsages)));
  }

  Future<void> _onWordFinalized(
      WordFinalized event, Emitter<ModifyWordState> emit) async {
    emit(ModifyWordState(
        partOfSpeech: state.partOfSpeech,
        forms: state.forms,
        usages: state.usages,
        status: ModifyWordStatus.LOADING));

    final errors = modifyWordStateValidator.validate(state);
    if (errors == null) {
      var word = createWord(state);
      // TODO: save to repository
    }

    emit(ModifyWordState(
        partOfSpeech: state.partOfSpeech,
        forms: state.forms,
        usages: state.usages,
        errors: errors,
        status: errors == null
            ? ModifyWordStatus.DONE
            : ModifyWordStatus.IN_PROGRESS));
  }
}