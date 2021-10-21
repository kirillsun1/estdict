import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WordOverview extends StatelessWidget {
  final Word _word;
  final WordFormType primaryForm;
  final WordFormType secondaryForm;

  const WordOverview(
      {Key? key,
      required Word word,
      this.primaryForm = WordFormType.EST_INF,
      this.secondaryForm = WordFormType.RUS_INF})
      : _word = word,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                this._word.findFormValue(primaryForm) ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(this._word.findFormValue(this.secondaryForm) ?? "")
            ],
          ),
          Chip(
            label: Text(this._word.partOfSpeech.name),
          )
        ],
      ),
    ));
  }
}
