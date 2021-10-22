import 'package:estdict/app/home/home_page.dart';
import 'package:estdict/domain/word.dart';
import 'package:estdict/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(EstDictionary());
}

const primaryColor = Color(0xffffb5a7);
const secondaryColor = Color(0xfffcd5ce);
const textColor = Color(0xff460000);

class EstDictionary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return RepositoryProvider(
      create: (context) => WordRepository(),
      child: MaterialApp(
        title: 'EST Dictionary',
        theme: createTheme(Brightness.light),
        darkTheme: createTheme(Brightness.dark),
        home: HomePage(),
      ),
    );
  }

  ThemeData createTheme(Brightness brightness) {
    var backgroundColor = brightness == Brightness.light
        ? lighten(secondaryColor, 50)
        : darken(secondaryColor, 50);
    var primary = brightness == Brightness.light
        ? primaryColor
        : darken(primaryColor, 60);
    var secondary = brightness == Brightness.light
        ? secondaryColor
        : darken(secondaryColor, 45);
    var text =
        brightness == Brightness.light ? textColor : lighten(primaryColor, 20);

    var themeData = ThemeData(
        cardColor: backgroundColor,
        colorScheme: brightness == Brightness.light
            ? ColorScheme.light(primary: primary, secondary: secondary)
            : ColorScheme.dark(primary: primary, secondary: secondary));
    return themeData.copyWith(
        textTheme: themeData.textTheme.apply(bodyColor: text),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: text),
            titleTextStyle: TextStyle(color: text, fontSize: 20.0)),
        chipTheme: themeData.chipTheme.copyWith(
            backgroundColor: secondary, labelStyle: TextStyle(color: text)));
  }
}
