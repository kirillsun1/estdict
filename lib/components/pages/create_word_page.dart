import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/word_type.dart';
import 'package:flutter/material.dart';

const padding = EdgeInsets.only(left: 18, right: 18);

class EditableForm {
  final WordFormType formType;
  String value;

  EditableForm(this.formType, [this.value = ""]);

  Map<String, dynamic> toJson() => {
        "formType": formType.toString(),
        "value": value,
      };
}

class EditableWord {
  final WordType wordType;
  List<EditableForm> forms = [];
  List<String> usages = [];

  EditableWord(this.wordType);

  String formValue(WordFormType wordFormType) {
    var value = _findForm(wordFormType)?.value;
    return value != null ? value : "";
  }

  void editFormValue(WordFormType wordFormType, String newValue) {
    var form = _findForm(wordFormType);
    if (form == null) {
      form = EditableForm(wordFormType);
      forms.add(form);
    }
    form.value = newValue;
  }

  EditableForm? _findForm(WordFormType wordFormType) {
    return forms.firstWhereIndexedOrNull(
        (i, element) => element.formType == wordFormType);
  }

  Map<String, dynamic> toJson() => {
        "wordType": wordType.toString(),
        "usages": usages,
        "forms": forms.map((f) => f.toJson()).toList()
      };
}

class CreateWordPage extends StatelessWidget {
  final EditableWord word;

  CreateWordPage({Key? key, required WordType wordType})
      : word = EditableWord(wordType),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var typeFormsByLanguages = wordTypesForms[this.word.wordType];
    if (typeFormsByLanguages == null) {
      throw StateError(
          "Type Forms aren't configured for " + this.word.wordType.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Fill the required fields:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                ...typeFormsByLanguages.entries.map((entry) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(entry.key.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        ...entry.value.map((formType) => Container(
                              margin: EdgeInsets.symmetric(vertical: 4.0),
                              child: TextFormField(
                                  initialValue: this.word.formValue(formType),
                                  onChanged: (value) =>
                                      this.word.editFormValue(formType, value),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 8.0),
                                    border: OutlineInputBorder(),
                                    labelText: formType.toString(),
                                  )),
                            ))
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () => print(jsonEncode(this.word.toJson())),
                        child: Text("Create"))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  get title {
    var wordTypeName = translateWordType(this.word.wordType);
    return "Create " + wordTypeName;
  }
}
