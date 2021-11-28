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
        title: Text("Word Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          _Header(word: word, primaryForm: primaryForm),
          SizedBox(
            height: 20,
          ),
          for (var formGroup in notEmptyFormsGroups) ...[
            Container(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: _WordFormGroup(formGroup: formGroup, word: word)),
            SizedBox(
              height: 10,
            )
          ],
          SizedBox(
            height: 20,
          ),
          _Usages(word: word),
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

class _WordFormGroup extends StatelessWidget {
  const _WordFormGroup({
    Key? key,
    required this.formGroup,
    required this.word,
  }) : super(key: key);

  final FormsGroup formGroup;
  final Word word;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        formGroup.name,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: themeData.textTheme.subtitle1?.fontSize),
      ),
      SizedBox(
        height: 10,
      ),
      for (var form in formGroup.allForms)
        if (word.forms.containsKey(form)) ...[
          Text(
            word.forms[form]!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(form.name),
          Divider(),
          SizedBox(
            height: 10,
          ),
        ]
    ]);
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.word,
    required this.primaryForm,
  }) : super(key: key);

  final Word word;
  final WordFormType primaryForm;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word.forms[primaryForm] ?? "",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: themeData.textTheme.headline5?.fontSize),
          ),
          Chip(
            label: Text(this.word.partOfSpeech.name),
          ),
        ],
      ),
    );
  }
}

class _Usages extends StatelessWidget {
  const _Usages({
    Key? key,
    required this.word,
  }) : super(key: key);

  final Word word;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
