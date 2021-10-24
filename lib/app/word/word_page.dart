import 'package:estdict/components/section.dart';
import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word_configuration/word_forms_configuration.dart';
import 'package:flutter/material.dart';

class WordPage extends StatelessWidget {
  final Word word;
  final WordFormType primaryForm;

  const WordPage(
      {Key? key, required this.word, this.primaryForm = WordFormType.EST_INF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notEmptyFormsGroups = _collectNotEmptyFormsGroups();

    return Scaffold(
      appBar: AppBar(
        title: Text(word.forms[primaryForm] ?? ""),
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
          for (var formsGroup in notEmptyFormsGroups)
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Section(title: formsGroup.name, children: [
                Row(
                  children: [
                    for (var formType in formsGroup.allForms)
                      if (word.forms.containsKey(formType))
                        Chip(label: Text(word.forms[formType]!))
                  ],
                )
              ]),
            ),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: word.usages.isNotEmpty
                ? Section(
                    title: "Usages",
                    children: [
                      for (var usage in word.usages) ...[
                        Text(usage),
                        SizedBox(height: 10)
                      ]
                    ],
                  )
                : Text("No usages added"),
          ),
        ],
      ),
    );
  }

  List<FormsGroup> _collectNotEmptyFormsGroups() {
    return word.partOfSpeech.groupedForms
        .where((formsGroup) => formsGroup.allForms
            .toSet()
            .intersection(word.forms.keys.toSet())
            .isNotEmpty)
        .toList();
  }
}
