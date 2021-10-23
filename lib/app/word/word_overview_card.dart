import 'package:estdict/app/word/word_page.dart';
import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      child: Padding(
        padding:
            const EdgeInsets.only(top: 4.0, left: 15, right: 15, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.word.findFormValue(primaryForm) ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(this.word.findFormValue(this.secondaryForm) ?? "")
              ],
            ),
            Chip(
              label: Text(this.word.partOfSpeech.name),
            )
          ],
        ),
      ),
    ));
  }

  openWordOverviewPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WordPage(word: word, primaryForm: primaryForm)));
  }
}
