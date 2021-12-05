import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:estdict/domain/word.dart';

class WordPageState {
  final int wordId;
  final bool loading;
  final Word? word;

  WordPageState.forWord(this.wordId)
      : loading = false,
        word = null;

  WordPageState._(
      {required this.wordId, required this.loading, required this.word});

  WordPageState copyWith({int? wordId, bool? loading, Word? word}) {
    return WordPageState._(
        wordId: wordId != null ? wordId : this.wordId,
        loading: loading != null ? loading : this.loading,
        word: word != null ? word : this.word);
  }
}

abstract class WordPageEvent {}

class WordRequested extends WordPageEvent {}

class WordPageBloc extends Bloc<WordPageEvent, WordPageState> {
  final WordRepository _wordRepository;
  late final StreamSubscription<WordRepositoryEvent>
      _wordRepositoryEventSubscription;

  WordPageBloc(this._wordRepository, int wordId)
      : super(WordPageState.forWord(wordId)) {
    on<WordRequested>(_onWordRequested);
    _wordRepositoryEventSubscription = _wordRepository.events.listen((event) {
      if (event == WordRepositoryEvent.WORD_CHANGED) {
        add(WordRequested());
      }
    });
  }

  void _onWordRequested(
      WordRequested event, Emitter<WordPageState> emit) async {
    try {
      emit(state.copyWith(loading: true));
      final word = await _wordRepository.findWordById(state.wordId);
      emit(state.copyWith(loading: false, word: word));
    } catch (e) {
      emit(state.copyWith(loading: false, word: null));
    }
  }

  @override
  Future<void> close() {
    _wordRepositoryEventSubscription.cancel();
    return super.close();
  }
}
