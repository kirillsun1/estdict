import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/word_type.dart';
import 'package:flutter/material.dart';

const padding = EdgeInsets.only(left: 18, right: 18);

class CreateWordPage extends StatelessWidget {
  final WordType wordType;

  const CreateWordPage({Key? key, required this.wordType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var typeFormsByLanguages = wordTypesForms[this.wordType];
    if (typeFormsByLanguages == null) {
      throw StateError(
          "Type Forms aren't configured for " + this.wordType.toString());
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
                              child: TextField(
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
                    ElevatedButton(onPressed: () => {}, child: Text("Create"))
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
    var wordTypeName = translateWordType(this.wordType);
    return "Create " + wordTypeName;
  }
}
