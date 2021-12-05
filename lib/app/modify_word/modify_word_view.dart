import 'package:estdict/components/section.dart';
import 'package:estdict/domain/word.dart';
import 'package:estdict/domain/word_configuration/word_forms_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_forms.dart';
import 'modify_word_bloc.dart';
import 'modify_word_state.dart';
import 'usages.dart';

class ModifyWordView extends StatelessWidget {
  const ModifyWordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModifyWordBloc, ModifyWordState>(
      builder: (context, state) {
        final partOfSpeech = state.partOfSpeech;
        return Scaffold(
          appBar: AppBar(
            title: Text((state.isEditMode ? "Edit" : "Create") +
                " " +
                partOfSpeech.name),
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
