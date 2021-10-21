import 'package:estdict/app/home/home_page_block.dart';
import 'package:estdict/app/word/word_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_bloc.dart';

class LastAddedWords extends StatelessWidget {
  const LastAddedWords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) => Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.loading)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()],
                        )
                      else if (state.words.isEmpty)
                        HomePageBlock(
                            child: Text(
                          'Your latest added words will appear here once you add new words.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                      else ...[
                        HomePageBlock(
                            child: Text(
                          'Here is what you learned previously:',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        SizedBox(height: 10),
                        HomePageBlock(
                                narrow: true,
                                child: Column(
                                  children: [
                                    ...state.words
                                        .map((word) => WordOverview(word: word))
                                  ],
                                ))
                          ]
                    ],
                  ),
                )
              ],
            ));
  }
}
