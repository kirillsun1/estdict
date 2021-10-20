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
  late final StreamSubscription<WordRepositoryEvent>
      _wordRepositoryEventSubscription;

  HomePageBloc(this._wordRepository) : super(HomePageState(false, [])) {
    on<WordsRequested>(_onWordsRequested);
    _wordRepositoryEventSubscription = _wordRepository.events.listen((event) {
      add(WordsRequested());
    });
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

  @override
  Future<void> close() {
    _wordRepositoryEventSubscription.cancel();
    // TODO: where is the best place for the disposal?
    _wordRepository.dispose();
    return super.close();
  }
}
