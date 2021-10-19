import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:estdict/domain/word.dart';

class HomePageState {
  final bool loading;
  final List<Word> words;

  HomePageState(this.loading, this.words);
}

abstract class HomePageEvent {}

class WordsRequested extends HomePageEvent {}

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final WordRepository _wordRepository;

  HomePageBloc(this._wordRepository) : super(HomePageState(false, [])) {
    on<WordsRequested>(_onWordsRequested);
    // TODO: subscribe to repo changes
  }

  Future<void> _onWordsRequested(
      WordsRequested event, Emitter<HomePageState> emit) async {
    try {
      emit(HomePageState(true, []));
      var words = await _wordRepository.getLatestWords();
      emit(HomePageState(false, words));
    } finally {
      emit(HomePageState(false, state.words));
    }
  }
}
