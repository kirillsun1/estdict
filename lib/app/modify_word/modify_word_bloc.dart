import 'dart:async';

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

class ModifyWordBloc extends Bloc<ModifyWordEvent, ModifyWordState> {
  ModifyWordBloc(ModifyWordState state) : super(state) {
    on<FormValueModified>(_onFormValueModified);
    on<WordFinalized>(_onWordFinalized);
  }

  void _onFormValueModified(
      FormValueModified event, Emitter<ModifyWordState> emit) {
    var forms = Map.of(state.forms);
    if (event.value == null) {
      forms.remove(event.type);
    } else {
      forms[event.type] = event.value!;
    }

    emit(ModifyWordState(state.partOfSpeech, Map.unmodifiable(forms)));
  }

  FutureOr<void> _onWordFinalized(
      WordFinalized event, Emitter<ModifyWordState> emit) {
    // TODO: Add Save
  }
}
