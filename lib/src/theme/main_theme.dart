import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color purple = Color(0xffc0b6ff);
const Color green = Color(0xffceff67);
const Color white = Color(0xfff7f7f7);
const Color grey = Color(0xffCDD0D8);
const Color lightGreen = Color(0xffE7FFDB);
const Color lightPurple = Color(0xffC9C5DF);
const Color darkgrey = Color.fromARGB(255, 37, 51, 56);
const Color black = Color(0xff252727);
const Color blue = Color.fromRGBO(130, 177, 255, 1);
const Color amber = Color.fromRGBO(255, 202, 40, 1);

const Color backgroundColor = white;
const Color darkColor = black;
const Color textColor = darkColor; //Colors.white;
const accentColor = green;
const secondaryColor = purple; //Colors.amber;

final TextStyle bodyTextStyle = GoogleFonts.poppins(
  color: textColor,
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

final TextStyle bodyTextWhiteStyle = bodyTextStyle.copyWith(
  color: white,
);

final TextStyle cardTextStyle = GoogleFonts.poppins(
  color: textColor,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final TextStyle deckTextStyle = GoogleFonts.poppins(
  color: white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const OutlinedBorder buttonShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)));

final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
  textStyle: cardTextStyle,
  onPrimary: white,
  primary: darkColor,
  shape: buttonShape,
  surfaceTintColor: white,
  splashFactory: InkSparkle.splashFactory,
);

final ButtonStyle lightOutlineButtonStyle = OutlinedButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
  side: const BorderSide(color: white, width: 2),
  textStyle: deckTextStyle,
  primary: white,
  shape: buttonShape,
  surfaceTintColor: white,
  splashFactory: InkSparkle.splashFactory,
);

final ButtonStyle lightOutlineCompressedButtonStyle = OutlinedButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
  side: const BorderSide(color: white, width: 2),
  textStyle: deckTextStyle,
  primary: white,
  shape: buttonShape,
  surfaceTintColor: white,
  splashFactory: InkSparkle.splashFactory,
);

final ButtonStyle darkOutlineButtonStyle = OutlinedButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
  side: const BorderSide(color: darkColor, width: 2),
  textStyle: cardTextStyle,
  primary: darkColor,
  shape: buttonShape,
  surfaceTintColor: darkColor,
  splashFactory: InkSparkle.splashFactory,
);

final ButtonStyle secondaryButton = ElevatedButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
  textStyle: cardTextStyle,
  onPrimary: darkColor,
  primary: green,
  shape: buttonShape,
  surfaceTintColor: white,
  splashFactory: InkSparkle.splashFactory,
);

ThemeData mainTheme = ThemeData.light().copyWith(
  backgroundColor: backgroundColor,
  brightness: Brightness.light,
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
  elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButtonStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: darkOutlineButtonStyle),
  buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: accentColor,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
  iconTheme: const IconThemeData(color: textColor, size: 30),
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
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0,
      color: Colors.transparent,
      actionsIconTheme: IconThemeData(color: textColor)),
);
