import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WordOverview extends StatelessWidget {
  final Word _word;

  const WordOverview({Key? key, required Word word})
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
                this._word.mainEstonianForm,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(this._word.mainRussianForm)
            ],
          ),
          Chip(
            label: Text(translateWordType(this._word.wordType)),
          )
        ],
      ),
    ));
  }
}
