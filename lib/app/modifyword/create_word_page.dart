import 'package:estdict/app/modifyword/modify_word_bloc.dart';
import 'package:estdict/app/modifyword/modify_word_state.dart';
import 'package:estdict/domain/part_of_speech.dart';
import 'package:estdict/domain/word_form.dart';
import 'package:estdict/domain/word_forms_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWordPage extends StatelessWidget {
  final PartOfSpeech partOfSpeech;

  CreateWordPage({Key? key, required this.partOfSpeech}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ModifyWordBloc(ModifyWordState.newWord(partOfSpeech)),
        child: CreateWordView());
  }
}

class CreateWordView extends StatelessWidget {
  const CreateWordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModifyWordBloc, ModifyWordState>(
      builder: (context, state) {
        final partOfSpeech = state.partOfSpeech;
        return Scaffold(
          appBar: AppBar(
            title: Text("Create " + partOfSpeech.name),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Fill the forms of the word.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'An infinitive of at least one language is required". You can optionally add additional forms.'),
                    SizedBox(
                      height: 10,
                    ),
                    for (var groupsForm in partOfSpeech.groupedForms)
                      LanguageForms(group: groupsForm),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () => print("hey"),
                            child: Text("Create"))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LanguageForms extends StatelessWidget {
  final FormsGroup group;

  const LanguageForms({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModifyWordBloc, ModifyWordState>(
        builder: (context, state) => LanguageFormsView(
            group: group,
            forms: state.forms,
            onFormValueChanged: (type, value) => context
                .read<ModifyWordBloc>()
                .add(FormValueModified(type, value))));
  }
}

typedef OnFormValueChanged = void Function(WordFormType, String?);

class LanguageFormsView extends StatelessWidget {
  final FormsGroup group;
  final Map<WordFormType, String> forms;
  final OnFormValueChanged onFormValueChanged;

  LanguageFormsView(
      {Key? key,
      required this.group,
      required this.forms,
      required this.onFormValueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var optionalFormsLeft =
        group.optionalForms.where((element) => !forms.containsKey(element));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          group.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          child: TextFormField(
              initialValue: forms[group.infinitive],
              onChanged: (value) =>
                  {onFormValueChanged(group.infinitive, value)},
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                border: OutlineInputBorder(),
                labelText: group.infinitive.name,
              )),
        ),
        for (var formType in group.optionalForms)
          if (formType != group.infinitive && forms.containsKey(formType))
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: forms[formType],
                        onChanged: (value) =>
                            {onFormValueChanged(formType, value)},
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 8.0),
                          border: OutlineInputBorder(),
                          labelText: formType.name,
                        )),
                  ),
                  IconButton(
                      onPressed: () => {onFormValueChanged(formType, null)},
                      icon: Icon(Icons.remove))
                ],
              ),
            ),
        if (optionalFormsLeft.isNotEmpty)
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
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
              onChanged: (value) => {
                if (value != null) {onFormValueChanged(value, "")}
              },
            ),
          )
      ],
    );
  }
}
