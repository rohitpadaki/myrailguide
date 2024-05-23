import 'package:flutter/material.dart';

String fontfamily = "Urbanist";

final ThemeData lightTheme = ThemeData(
  useMaterial3: false,
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF5F5F5),
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 95),
  primaryColor: const Color(0xff225fde),
  primaryColorLight: const Color(0xffd3dff8),
  primaryColorDark: const Color(0xff143985),
  canvasColor: const Color(0xFFF5F5F5),
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  cardColor: const Color(0xffffffff),
  dividerColor: const Color(0xff000000),
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  unselectedWidgetColor: const Color(0x8a000000),
  disabledColor: const Color(0x61000000),
  secondaryHeaderColor: const Color(0xffe9effc),
  dialogBackgroundColor: const Color(0xffffffff),
  indicatorColor: const Color(0xff215ede),
  hintColor: const Color(0x8a000000),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    minWidth: double.infinity,
    padding: EdgeInsets.all(17),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    alignedDropdown: false,
    buttonColor: Color(0xff4e61d9),
    disabledColor: Color(0x61000000),
    highlightColor: Color(0x00000000),
    splashColor: Color(0x1fffffff),
    focusColor: Color(0x1f000000),
    hoverColor: Color(0x0a000000),
    colorScheme: ColorScheme(
      primary: Color(0xff225fde),
      secondary: Color(0xff215ede),
      surface: Color(0xffffffff),
      background: Color(0xffa6bff2),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onBackground: Color(0xffffffff),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
        color: Colors.black,
        fontFamily: fontfamily,
        fontSize: 36,
        fontWeight: FontWeight.w700),

    titleMedium: TextStyle(
      color: Colors.black,
      fontFamily: fontfamily,
      fontSize: 25,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontFamily: fontfamily,
      fontSize: 18,
    ),
    headlineMedium: TextStyle(
        color: Colors.black,
        fontFamily: fontfamily,
        fontSize: 23,
        fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontFamily: fontfamily,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: 0.50,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontFamily: fontfamily,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: 0.04,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
      fontSize: 13,
      fontFamily: fontfamily,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: 0.40,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontFamily: fontfamily,
      fontWeight: FontWeight.w500,
      height: 0,
      letterSpacing: 0.50,
    ),
    // Add other text styles as needed
  ),
  primaryTextTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    // Add other text styles as needed
  ),
  inputDecorationTheme: const InputDecorationTheme(
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xff225fde),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  sliderTheme: const SliderThemeData(
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color(0x1f000000),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde000000),
    disabledColor: Color(0x0c000000),
    labelPadding: EdgeInsets.symmetric(horizontal: 8),
    labelStyle: TextStyle(
      color: Color(0xde000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color(0x3d225fde),
    selectedColor: Color(0x3d000000),
    shape: StadiumBorder(side: BorderSide.none),
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xff4285f4),
    selectionColor: Color(0xffa6bff2),
    selectionHandleColor: Color(0xff7a9feb),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return const Color(0xff1b4bb1);
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return const Color(0xff1b4bb1);
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return const Color(0xff1b4bb1);
      }
      return null;
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return const Color(0xff1b4bb1);
      }
      return null;
    }),
  ),
  colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(4280442846, {
    50: Color(0xffe9effc),
    100: Color(0xffd3dff8),
    200: Color(0xffa6bff2),
    300: Color(0xff7a9feb),
    400: Color(0xff4e7ee4),
    500: Color(0xff215ede),
    600: Color(0xff1b4bb1),
    700: Color(0xff143985),
    800: Color(0xff0d2659),
    900: Color(0xff07132c),
  }))
      .copyWith(secondary: const Color(0xff215ede))
      .copyWith(background: const Color(0xffa6bff2))
      .copyWith(error: const Color(0xffd32f2f)),
  bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xffffffff)),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1B1F),
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 100),
  primaryColor: const Color(0xff225fde),
  primaryColorLight: const Color(0xffd3dff8),
  primaryColorDark: const Color(0xff143985),
  canvasColor: const Color(0xFF1C1B1F),
  scaffoldBackgroundColor: const Color(0xFF1C1B1F),
  cardColor: const Color(0xff363636),
  dividerColor: const Color(0xffffffff),
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  unselectedWidgetColor: const Color(0x8a000000),
  disabledColor: const Color(0x61000000),
  secondaryHeaderColor: const Color(0xffe9effc),
  dialogBackgroundColor: const Color(0xffffffff),
  indicatorColor: const Color(0xff215ede),
  hintColor: const Color(0x8a000000),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    minWidth: double.infinity,
    padding: EdgeInsets.all(17),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    alignedDropdown: false,
    buttonColor: Color(0xff4e61d9),
    disabledColor: Color(0x61000000),
    highlightColor: Color(0x00000000),
    splashColor: Color(0x1fffffff),
    focusColor: Color(0x1f000000),
    hoverColor: Color(0x0a000000),
    colorScheme: ColorScheme(
      primary: Color(0xff225fde),
      secondary: Color(0xff215ede),
      surface: Color(0xffffffff),
      background: Color(0xffa6bff2),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onBackground: Color(0xffffffff),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
        color: Colors.white,
        fontFamily: fontfamily,
        fontSize: 36,
        fontWeight: FontWeight.w700),

    titleMedium: TextStyle(
      color: Colors.white,
      fontFamily: fontfamily,
      fontSize: 25,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontFamily: fontfamily,
      fontSize: 18,
    ),
    headlineMedium: TextStyle(
        color: Colors.white,
        fontFamily: fontfamily,
        fontSize: 23,
        fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontFamily: fontfamily,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: 0.50,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontFamily: fontfamily,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: 0.04,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontFamily: fontfamily,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: 0.40,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontFamily: fontfamily,
      fontWeight: FontWeight.w500,
      height: 0,
      letterSpacing: 0.50,
    ),
    // Add other text styles as needed
  ),
  primaryTextTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Color(0xb3ffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    // Add other text styles as needed
  ),
  inputDecorationTheme: const InputDecorationTheme(
    counterStyle: TextStyle(color: Colors.white),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffffff), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffffff), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffffff), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffffff), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffffff), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffffffff), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xff225fde),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  sliderTheme: const SliderThemeData(
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color(0x1f000000),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde000000),
    disabledColor: Color(0x0c000000),
    labelPadding: EdgeInsets.symmetric(horizontal: 8),
    labelStyle: TextStyle(
      color: Color(0xde000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color(0x3d225fde),
    selectedColor: Color(0x3d000000),
    shape: StadiumBorder(side: BorderSide.none),
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xff4285f4),
    selectionColor: Color(0xffa6bff2),
    selectionHandleColor: Color(0xff7a9feb),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return const Color(0xff1b4bb1);
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return const Color(0xff1b4bb1);
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return const Color(0xff1b4bb1);
      }
      return null;
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return const Color(0xff1b4bb1);
      }
      return null;
    }),
  ),
  colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(4280442846, {
    50: Color(0xffe9effc),
    100: Color(0xffd3dff8),
    200: Color(0xffa6bff2),
    300: Color(0xff7a9feb),
    400: Color(0xff4e7ee4),
    500: Color(0xff215ede),
    600: Color(0xff1b4bb1),
    700: Color(0xff143985),
    800: Color(0xff0d2659),
    900: Color(0xff07132c),
  }))
      .copyWith(secondary: const Color(0xff215ede))
      .copyWith(background: const Color(0xffa6bff2))
      .copyWith(error: const Color(0xffd32f2f)),
  bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xffffffff)),
);
