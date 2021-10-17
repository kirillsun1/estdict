import 'package:estdict/app/modify_word/modify_word_bloc.dart';
import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/app/modify_word/text_field.dart';
import 'package:estdict/components/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Usages extends StatelessWidget {
  const Usages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModifyWordBloc, ModifyWordState>(
        builder: (context, state) => _UsagesView(
            usages: state.usages,
            onUsageChanged: (index, value) {
              context.read<ModifyWordBloc>().add(UsageModified(index, value));
            }));
  }
}

typedef UsageChanged = void Function(int, String?);

class _UsagesView extends StatelessWidget {
  final List<String?> usages;
  final UsageChanged onUsageChanged;

  const _UsagesView(
      {Key? key, required this.usages, required this.onUsageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section(title: "Usages", children: [
      for (var i = 0; i < usages.length; i++)
        if (usages[i] != null)
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: ModifyWordTextField(
                    keySuffix: "usage__$i",
                    value: usages[i],
                    onFormChanged: (value) => {onUsageChanged(i, value)},
                  ),
                ),
                IconButton(
                    onPressed: () => {onUsageChanged(i, null)},
                    icon: Icon(Icons.delete))
              ],
            ),
          ),
      TextButton.icon(
          onPressed: () => onUsageChanged(usages.length, ""),
          icon: Icon(Icons.add),
          label: Text("Add new usage"))
    ]);
  }
}
