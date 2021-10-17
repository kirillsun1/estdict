import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:estdict/app/word/word_repository.dart';
import 'package:estdict/domain/word.dart';

class HomePageState {
  final bool loading;
  final List<Word> words;

  HomePageState(this.loading, this.words);
}

abstract class HomePageEvent {}

class WordsRequested extends HomePageEvent {}

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final WordRepository wordRepository;

  HomePageBloc(this.wordRepository) : super(HomePageState(false, [])) {
    on<WordsRequested>(_onWordsRequested);
  }

  Future<void> _onWordsRequested(
      WordsRequested event, Emitter<HomePageState> emit) async {
    try {
      emit(HomePageState(true, []));
      var words = await wordRepository.getLatestWords();
      emit(HomePageState(false, words));
    } finally {
      emit(HomePageState(false, state.words));
    }
  }
}
