import 'package:estdict/app/modify_word/modify_word_bloc.dart';
import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/app/modify_word/text_field.dart';
import 'package:estdict/components/section.dart';
import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word/word_form.dart';
import 'package:estdict/domain/word_configuration/word_forms_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageForms extends StatelessWidget {
  final FormsGroup group;

  const LanguageForms({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModifyWordBloc, ModifyWordState>(
        builder: (context, state) => LanguageFormsView(
            group: group,
            forms: state.forms,
            enabled: state.status == ModifyWordStatus.IN_PROGRESS,
            errors: state.errors,
            onFormValueChanged: (type, value) => context
                .read<ModifyWordBloc>()
                .add(FormValueModified(type, value))));
  }
}

typedef OnFormValueChanged = void Function(WordFormType, String?);

const margin = EdgeInsets.symmetric(vertical: 4.0);

class LanguageFormsView extends StatelessWidget {
  final FormsGroup group;
  final Map<WordFormType, String> forms;
  final OnFormValueChanged onFormValueChanged;
  final bool enabled;
  final WordValidationErrors? errors;

  LanguageFormsView(
      {Key? key,
      required this.group,
      required this.forms,
      required this.enabled,
      required this.onFormValueChanged,
      required this.errors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section(title: group.name, children: [
      Container(
        margin: margin,
        child: FormValueField(
          formType: group.infinitive,
          value: forms[group.infinitive],
          onFormValueChanged: onFormValueChanged,
          enabled: enabled,
          error: infinitiveError,
        ),
      ),
      for (var formType in group.optionalForms)
        if (isOptionalFormWithValue(formType))
          Container(
            margin: margin,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FormValueField(
                    formType: formType,
                    value: forms[formType],
                    onFormValueChanged: onFormValueChanged,
                    enabled: enabled,
                    error: errors?.isFormInvalid(formType) ?? false
                        ? "Cannot be empty or contain only spaces."
                        : null,
                  ),
                ),
                IconButton(
                    onPressed: enabled
                        ? () => {onFormValueChanged(formType, null)}
                        : null,
                    icon: Icon(Icons.delete))
              ],
            ),
          ),
      if (optionalFormsLeft.isNotEmpty)
        Container(
          margin: margin,
          child: DropdownButton<WordFormType>(
            value: null,
            hint: Text("Select a form to add"),
            isExpanded: true,
            items: optionalFormsLeft
                .map((element) => DropdownMenuItem(
                      child: Text(element.name),
                      value: element,
                    ))
                .toList(),
            onChanged: enabled
                ? (value) => {
                      if (value != null) {onFormValueChanged(value, "")}
                    }
                : null,
          ),
        )
    ]);
  }

  String? get infinitiveError {
    List<String> all = [];
    if (errors?.missingInfinitive ?? false) {
      all.add("At least one infinitive is required");
    }
    if (errors?.isFormInvalid(group.infinitive) ?? false) {
      all.add("Cannot be empty or contain only spaces.");
    }
    return all.isNotEmpty ? all.join(" ") : null;
  }

  bool isOptionalFormWithValue(WordFormType formType) =>
      formType != group.infinitive && forms.containsKey(formType);

  Iterable<WordFormType> get optionalFormsLeft =>
      group.optionalForms.where((element) => !forms.containsKey(element));
}

class FormValueField extends StatelessWidget {
  final WordFormType formType;
  final String? value;
  final String? error;
  final OnFormValueChanged onFormValueChanged;
  final bool enabled;

  const FormValueField(
      {Key? key,
      required this.formType,
      required this.value,
      this.error,
      required this.onFormValueChanged,
      required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModifyWordTextField(
      keySuffix: "form__$formType",
      value: value,
      onFormChanged: (value) => {onFormValueChanged(formType, value)},
      hint: formType.name,
      enabled: enabled,
      error: error,
    );
  }
}
