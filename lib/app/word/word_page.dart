import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';

class WordPage extends StatelessWidget {
  final Word word;
  final WordFormType primaryForm;

  const WordPage(
      {Key? key, required this.word, this.primaryForm = WordFormType.EST_INF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word.findFormValue(primaryForm) ?? ""),
      ),
      body: Text(word.toString()),
    );
  }
}
