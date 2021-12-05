import 'package:bloc/bloc.dart';
import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word/word_validator.dart';

import 'modify_word_state.dart';
import 'word_converter.dart';

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
  final WordValidator _wordValidator;
  final WordRepository _wordRepository;

  ModifyWordBloc(ModifyWordState state, this._wordRepository,
      [this._wordValidator = const WordValidator()])
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

    emit(state.copyWith(forms: Map.unmodifiable(forms)));
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

    emit(state.copyWith(usages: List.unmodifiable(modifiableUsages)));
  }

  Future<void> _onWordFinalized(
      WordFinalized event, Emitter<ModifyWordState> emit) async {
    emit(state.copyWith(status: ModifyWordStatus.LOADING));

    final word = createWord(state);
    final errors = _wordValidator.validate(word);
    if (errors == null) {
      await _wordRepository.save(word);
    }

    emit(state.copyWith(
        errors: errors,
        status: errors == null
            ? ModifyWordStatus.DONE
            : ModifyWordStatus.IN_PROGRESS));
  }
}
