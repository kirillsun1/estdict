import 'package:flutter/material.dart';

class ModifyWordTextField extends StatelessWidget {
  final String keySuffix;
  final String? value;
  final String? hint;
  final String? error;
  final bool enabled;
  final Function(String) onFormChanged;

  const ModifyWordTextField(
      {Key? key,
      required this.keySuffix,
      required this.value,
      this.hint,
      this.error,
      this.enabled = true,
      required this.onFormChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: Key("modifyWordField__$keySuffix"),
        initialValue: value,
        onChanged: onFormChanged,
        enabled: enabled,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          border: OutlineInputBorder(),
          labelText: hint,
            errorText: error));
  }
}
