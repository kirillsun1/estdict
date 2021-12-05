import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modify_word_bloc.dart';
import 'modify_word_state.dart';
import 'modify_word_view.dart';

class CreateWordPage extends StatelessWidget {
  final PartOfSpeech partOfSpeech;

  CreateWordPage({Key? key, required this.partOfSpeech}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ModifyWordBloc(
            ModifyWordState.newWord(partOfSpeech),
            context.read<WordRepository>()),
        child: BlocListener<ModifyWordBloc, ModifyWordState>(
            listener: (context, state) {
              if (state.status == ModifyWordStatus.DONE) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }
            },
            child: ModifyWordView()));
  }
}
