import 'package:flutter/material.dart';

final fontSize = 16.0;

class CustomTheme {
  static final appBarTitle = TextStyle(fontSize: fontSize + 6.0);
  static final appBarTitleBold = TextStyle(fontSize: fontSize + 6.0, fontWeight: FontWeight.bold);

  static final title = TextStyle(fontSize: fontSize + 6.0);
  static final titleBold = TextStyle(fontSize: fontSize + 6.0, fontWeight: FontWeight.bold);

  static final subTitle = TextStyle(fontSize: fontSize + 2.0);
  static final subTitleBold = TextStyle(fontSize: fontSize + 2.0, fontWeight: FontWeight.bold);

  static final bodyText = TextStyle(fontSize: fontSize);
  static final bodyTextBold = TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold);

  static final footText = TextStyle(fontSize: fontSize - 6.0);
  static final footTextBold = TextStyle(fontSize: fontSize - 6.0, fontWeight: FontWeight.bold);

  static final primaryColor = Color.fromRGBO(245, 40, 55, 1.0);
  static final primaryColorLight = Color.fromRGBO(255, 102, 98, 1.0);
  static final primaryColorDark = Color.fromRGBO(186, 0, 16, 1.0);

  static final dividerColor = Color(0x1F000000);
}

final theme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: CustomTheme.primaryColor,
  primaryColorLight: CustomTheme.primaryColorLight,
  primaryColorDark: CustomTheme.primaryColorDark,
  fontFamily: 'Titillium Web',
  appBarTheme: AppBarTheme(
    centerTitle: false,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: fontSize + 82.0),
      headline2: TextStyle(fontSize: fontSize + 46.0),
      headline3: TextStyle(fontSize: fontSize + 34.0),
      headline4: TextStyle(fontSize: fontSize + 20.0),
      headline5: CustomTheme.appBarTitleBold,
      headline6: CustomTheme.appBarTitle,
      subtitle1: TextStyle(fontSize: fontSize + 2.0),
      subtitle2: TextStyle(fontSize: fontSize),
      bodyText1: TextStyle(fontSize: fontSize + 2.0),
      bodyText2: TextStyle(fontSize: fontSize),
      button: TextStyle(fontSize: fontSize),
      caption: TextStyle(fontSize: fontSize - 2.0),
      overline: TextStyle(fontSize: fontSize - 4.0),
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: fontSize + 82.0),
    headline2: TextStyle(fontSize: fontSize + 46.0),
    headline3: TextStyle(fontSize: fontSize + 34.0),
    headline4: TextStyle(fontSize: fontSize + 20.0),
    headline5: CustomTheme.titleBold,
    headline6: CustomTheme.title,
    subtitle1: CustomTheme.subTitle,
    subtitle2: CustomTheme.subTitleBold,
    bodyText1: CustomTheme.bodyTextBold,
    bodyText2: CustomTheme.bodyText,
    button: TextStyle(fontSize: fontSize),
    caption: TextStyle(fontSize: fontSize - 2.0),
    overline: TextStyle(fontSize: fontSize - 4.0),
  ),
  dividerColor: CustomTheme.dividerColor,
);
