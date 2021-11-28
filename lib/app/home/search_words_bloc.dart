import 'package:bloc/bloc.dart';
import 'package:estdict/domain/word.dart';

class SearchWordsTabState {
  final bool loading;
  final List<Word> words;

  SearchWordsTabState(this.loading, this.words);
}

abstract class SearchWordsTabEvent {}

class WordsRequested extends SearchWordsTabEvent {}

class SearchWordsTabBloc
    extends Bloc<SearchWordsTabEvent, SearchWordsTabState> {
  final WordRepository _wordRepository;

  SearchWordsTabBloc(this._wordRepository)
      : super(SearchWordsTabState(false, [])) {
    on<WordsRequested>(_onWordsRequested);
  }

  Future<void> _onWordsRequested(
      WordsRequested event, Emitter<SearchWordsTabState> emit) async {
    try {
      emit(SearchWordsTabState(true, []));
      // TODO: proper loading with infinite scroll is to be implemented later
      var words = await _wordRepository.findWords(WordsQuery(maxResults: 200));
      emit(SearchWordsTabState(false, words));
    } catch (e) {
      emit(SearchWordsTabState(false, []));
    }
  }
}
