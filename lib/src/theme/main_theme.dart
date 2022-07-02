import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color purple = Color(0xffc0b6ff);
const Color green = Color(0xffceff67);
const Color white = Color(0xfff7f7f7);
const Color darkgrey = Color.fromARGB(255, 37, 51, 56);
const Color black = Color(0xff252727);
const Color blue = Color.fromRGBO(130, 177, 255, 1);
const Color amber = Color.fromRGBO(255, 202, 40, 1);

const Color backgroundColor = white;
const Color darkColor = black;
const Color textColor = darkColor; //Colors.white;
const accentColor = green;
const secondaryColor = purple; //Colors.amber;

final TextStyle cardTextStyle = GoogleFonts.inter(
  color: textColor,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

final TextStyle deckTextStyle = GoogleFonts.inter(
  color: white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

final ButtonStyle primaryButton = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
    textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    backgroundColor: MaterialStateProperty.all<Color>(darkColor),
    foregroundColor: MaterialStateProperty.all<Color>(white));

final ButtonStyle secondaryButton = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
    textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    backgroundColor: MaterialStateProperty.all<Color>(accentColor),
    foregroundColor: MaterialStateProperty.all<Color>(darkColor));

ThemeData mainTheme = ThemeData.light().copyWith(
  backgroundColor: backgroundColor,
  brightness: Brightness.dark,
  primaryColor: accentColor,
  dialogTheme: const DialogTheme(
      titleTextStyle:
          TextStyle(color: black, fontSize: 20, fontWeight: FontWeight.bold),
      backgroundColor: white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)))),
  textTheme: Typography.material2021().black.copyWith(
      headline2: const TextStyle(
        color: textColor,
      ),
      headline5: const TextStyle(
        color: textColor,
      )),
  textButtonTheme: TextButtonThemeData(
    style:
        ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(black)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButton),
  buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: accentColor,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
  iconTheme: const IconThemeData(color: textColor),
  sliderTheme: SliderThemeData(
    activeTrackColor: accentColor,
    activeTickMarkColor: accentColor,
    trackHeight: 10.0,
    overlayColor: accentColor.withOpacity(.5),
    thumbColor: accentColor,
    inactiveTrackColor: accentColor.withOpacity(.5),
    inactiveTickMarkColor: accentColor.withOpacity(.5),
  ),
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0,
      color: backgroundColor,
      actionsIconTheme: IconThemeData(color: textColor)),
);
