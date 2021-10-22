import 'package:flutter/widgets.dart';

class Section extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;

  const Section(
      {Key? key, required this.title, this.subtitle, this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        if (subtitle != null) Text(subtitle!),
        SizedBox(
          height: 10,
        ),
        ...children,
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
