import 'package:estdict/components/section.dart';
import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word_configuration/word_forms_configuration.dart';
import 'package:flutter/material.dart';

class WordPage extends StatelessWidget {
  final Word word;
  final WordFormType primaryForm;

  const WordPage({Key? key, required this.word, this.primaryForm = WordFormType.EST_INF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word.findFormValue(primaryForm) ?? ""),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Text(word.partOfSpeech.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 20,
          ),
          for (var group in word.partOfSpeech.groupedForms)
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Section(title: group.name, children: [
                Row(
                  children: [
                    for (var formType in [
                      group.infinitive,
                      ...group.optionalForms
                    ])
                      if (word.findFormValue(formType) != null)
                        Chip(label: Text(word.findFormValue(formType)!))
                  ],
                )
              ]),
            ),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Section(
              title: "Usages",
              children: [for (var usage in word.usages) Text(usage)],
            ),
          )
        ],
      ),
    );
  }
}
