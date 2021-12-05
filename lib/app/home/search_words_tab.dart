import 'package:estdict/app/word/word_page.dart';
import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_block.dart';
import 'search_words_bloc.dart';

class SearchWordsTab extends StatelessWidget {
  const SearchWordsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchWordsTabBloc(context.read<WordRepository>())
          ..add(WordsRequested()),
        child: _SearchWordsTabView());
  }
}

class _SearchWordsTabView extends StatelessWidget {
  final WordFormType primaryForm;
  final WordFormType secondaryForm;

  const _SearchWordsTabView(
      {Key? key,
      this.primaryForm = WordFormType.EST_INF,
      this.secondaryForm = WordFormType.RUS_INF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchWordsTabBloc, SearchWordsTabState>(
        builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                SizedBox(
                  height: 30,
                ),
                HomePageBlock(
                  child: Text(
                    'All Words',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (state.loading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => ListTile(
                            title: Text(
                              state.words[index].forms[primaryForm] ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                state.words[index].forms[secondaryForm] ?? ""),
                            leading: Icon(Icons.bookmark),
                            trailing: Chip(
                              label: Text(state.words[index].partOfSpeech.name),
                            ),
                            onTap: () {
                              openWordOverviewPage(context, state.words[index]);
                            },
                          ),
                      itemCount: state.words.length),
                )
              ],
            ));
  }

  openWordOverviewPage(BuildContext context, Word word) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WordPage(wordId: word.id!)));
  }
}
