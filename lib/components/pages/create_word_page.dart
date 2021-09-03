import 'package:estdict/domain/word.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateWordPage extends StatelessWidget {
  final WordType wordType;

  const CreateWordPage({Key? key, required this.wordType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Text(""),
    );
  }

  get title {
    var wordTypeName = translateWordType(this.wordType);
    return "Create " + wordTypeName;
  }
}
