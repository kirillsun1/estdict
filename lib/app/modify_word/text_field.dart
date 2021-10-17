import 'package:flutter/material.dart';

class ModifyWordTextField extends StatelessWidget {
  final String keySuffix;
  final String? value;
  final String? hint;
  final Function(String) onFormChanged;

  const ModifyWordTextField(
      {Key? key,
      required this.keySuffix,
      required this.value,
      this.hint,
      required this.onFormChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: Key("modifyWordField__$keySuffix"),
        initialValue: value,
        onChanged: onFormChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          border: OutlineInputBorder(),
          labelText: hint,
        ));
  }
}
