import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'word_page.dart';

class WordOverviewCard extends StatelessWidget {
  final Word word;
  final WordFormType primaryForm;
  final WordFormType secondaryForm;

  const WordOverviewCard(
      {Key? key,
      required this.word,
      this.primaryForm = WordFormType.EST_INF,
      this.secondaryForm = WordFormType.RUS_INF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () {
        openWordOverviewPage(context);
      },
      child: Container(
        padding:
            const EdgeInsets.only(top: 6.0, left: 18, right: 18, bottom: 6.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    this.word.forms[primaryForm] ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    this.word.forms[this.secondaryForm] ?? "",
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            SizedBox(width: 15),
            Chip(
              label: Text(this.word.partOfSpeech.name),
            )
          ],
        ),
      ),
    ));
  }

  openWordOverviewPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WordPage(wordId: word.id!)));
  }
}
