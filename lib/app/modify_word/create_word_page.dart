import 'package:estdict/app/modify_word/modify_word_bloc.dart';
import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/domain/part_of_speech.dart';
import 'package:estdict/domain/word_forms_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_forms.dart';

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
                            onPressed: () {
                              context
                                  .read<ModifyWordBloc>()
                                  .add(WordFinalized());

                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
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
