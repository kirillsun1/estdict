import 'package:estdict/app/modify_word/modify_word_bloc.dart';
import 'package:estdict/app/modify_word/modify_word_state.dart';
import 'package:estdict/app/modify_word/text_field.dart';
import 'package:estdict/components/section.dart';
import 'package:estdict/domain/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Usages extends StatelessWidget {
  const Usages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModifyWordBloc, ModifyWordState>(
        builder: (context, state) => _UsagesView(
            usages: state.usages,
            enabled: state.status == ModifyWordStatus.IN_PROGRESS,
            errors: state.errors,
            onUsageChanged: (index, value) {
              context.read<ModifyWordBloc>().add(UsageModified(index, value));
            }));
  }
}

typedef UsageChanged = void Function(int, String?);

class _UsagesView extends StatelessWidget {
  final List<String?> usages;
  final UsageChanged onUsageChanged;
  final bool enabled;
  final WordValidationErrors? errors;

  const _UsagesView(
      {Key? key,
      required this.usages,
      required this.onUsageChanged,
      required this.enabled,
      required this.errors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section(title: "Usages", children: [
      for (var i = 0; i < usages.length; i++)
        if (usages[i] != null)
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ModifyWordTextField(
                    keySuffix: "usage__$i",
                    value: usages[i],
                    onFormChanged: (value) => {onUsageChanged(i, value)},
                    enabled: enabled,
                    error: errors?.isUsageInvalid(i) ?? false
                        ? "Cannot be empty or contain only spaces."
                        : null,
                  ),
                ),
                IconButton(
                    onPressed: enabled ? () => {onUsageChanged(i, null)} : null,
                    icon: Icon(Icons.delete))
              ],
            ),
          ),
      TextButton.icon(
          onPressed: enabled ? () => onUsageChanged(usages.length, "") : null,
          icon: Icon(Icons.add),
          label: Text("Add new usage"))
    ]);
  }
}
