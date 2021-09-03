import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/word_type.dart';
import 'package:flutter/material.dart';

const padding = EdgeInsets.only(left: 18, right: 18);

class CreateWordPage extends StatefulWidget {
  final WordType wordType;

  const CreateWordPage({Key? key, required this.wordType}) : super(key: key);

  @override
  _CreateWordPageState createState() => _CreateWordPageState();
}

class _CreateWordPageState extends State<CreateWordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var typeFormsByLanguages = wordTypesForms[this.widget.wordType];
    if (typeFormsByLanguages == null) {
      throw StateError("Type Forms aren't configured for " +
          this.widget.wordType.toString());
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
            child: Form(
              key: _formKey,
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
                          ...entry.value.map((formType) => TextFormField(
                                  decoration: InputDecoration(
                                labelText: formType.toString(),
                              )))
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  get title {
    var wordTypeName = translateWordType(this.widget.wordType);
    return "Create " + wordTypeName;
  }
}
