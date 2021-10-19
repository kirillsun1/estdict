import 'package:estdict/app/modify_word/modify_word_bloc.dart';
import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/app/modify_word/usages.dart';
import 'package:estdict/components/section.dart';
import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word_configuration/word_forms_configuration.dart';
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
        child: BlocListener<ModifyWordBloc, ModifyWordState>(
            listener: (context, state) {
              if (state.status == ModifyWordStatus.DONE) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }
            },
            child: CreateWordView()));
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
            actions: [
              IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    context.read<ModifyWordBloc>().add(WordFinalized());
                  })
            ],
          ),
          body: ListView(
            children: [
              if (state.status == ModifyWordStatus.LOADING)
                LinearProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Section(
                  title: 'Fill the forms of the word.',
                  subtitle:
                      'An infinitive of at least one language is required. You can optionally add additional forms.',
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    for (var groupsForm in partOfSpeech.groupedForms)
                      LanguageForms(group: groupsForm),
                    Usages()
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
