import 'package:estdict/components/pages/home_page.dart';
import 'package:estdict/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EstDictionary());
}

const primaryColor = Color(0xffffb5a7);
const secondaryColor = Color(0xfffcd5ce);
const darkModeModifiers = [15, 25, 35];
final textTheme = TextTheme(
    bodyText2: TextStyle(color: darken(Colors.deepOrange.shade800, 30)));

class EstDictionary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EST Dictionary',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        primarySwatch: Colors.deepOrange,
        cardColor: lighten(secondaryColor),
        textTheme: textTheme,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: darken(primaryColor, darkModeModifiers[0]),
          accentColor: darken(secondaryColor, darkModeModifiers[0]),
          primarySwatch: Colors.deepOrange,
          cardColor: darken(primaryColor, darkModeModifiers[1])),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
