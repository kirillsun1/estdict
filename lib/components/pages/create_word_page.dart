import 'package:collection/collection.dart';
import 'package:estdict/domain/part_of_speech.dart';
import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/word_forms_configuration.dart';
import 'package:flutter/material.dart';

const padding = EdgeInsets.only(left: 18, right: 18);

class EditableForm {
  final WordFormType formType;
  String value;

  EditableForm(this.formType, [this.value = ""]);
}

class EditableWord {
  final PartOfSpeech partOfSpeech;
  List<EditableForm> forms = [];
  List<String> usages = [];

  EditableWord(this.partOfSpeech);

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
}

class CreateWordPage extends StatelessWidget {
  final EditableWord word;

  CreateWordPage({Key? key, required PartOfSpeech partOfSpeech})
      : word = EditableWord(partOfSpeech),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create " + this.word.partOfSpeech.name),
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
                for (var lang in this.word.partOfSpeech.groupedForms.entries)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(lang.key.name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      for (var formType in lang.value)
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          child: TextFormField(
                              initialValue: this.word.formValue(formType),
                              onChanged: (value) =>
                                  this.word.editFormValue(formType, value),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 8.0),
                                border: OutlineInputBorder(),
                                labelText: formType.name,
                              )),
                        )
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () => print("hey"), child: Text("Create"))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
