import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/part_of_speech.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const _primaryFormToShow = WordFormType.EST_INF;

class WordOverview extends StatelessWidget {
  final Word _word;
  final WordFormType additionalFormToShow;

  const WordOverview(
      {Key? key,
      required Word word,
      this.additionalFormToShow = WordFormType.RUS_INF})
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
                this._word.findFormValue(_primaryFormToShow) ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(this._word.findFormValue(this.additionalFormToShow) ?? "")
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
