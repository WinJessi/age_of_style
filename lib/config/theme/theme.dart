import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData theme(BuildContext context) => ThemeData(
      fontFamily: 'SF Pro Text',
      primaryColorDark: Colors.black,
      primaryColorLight: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        bodyText1: const TextStyle(
          color: Color(0xFF0E0E0D),
          fontFamily: 'SF Pro Text',
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          // height: 1.5,
        ),
        bodyText2: const TextStyle(
          color: Color(0xFF0E0E0D),
          fontFamily: 'SF Pro Text',
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
        ),
        headline1: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 17,
        ),
        headline2: const TextStyle(
          fontFamily: 'SF Pro Text',
          color: Color.fromRGBO(74, 40, 32, 1),
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
        headline3: const TextStyle(
          fontFamily: 'SF Pro Text',
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
        headline4: ThemeData.light().textTheme.headline4?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro Text',
              decoration: TextDecoration.none,
              fontStyle: FontStyle.normal,
            ),
      ),
      primaryColor: Colors.black,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        // buttonColor: Color(0xFFFF3408),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textTheme: ButtonTextTheme.primary,
        disabledColor: Colors.grey,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      primaryIconTheme: const IconThemeData(color: Colors.black),
      cardTheme: CardTheme(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 0,
      ),
      dialogTheme: DialogTheme.of(context).copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          // side: BorderSide(color: Color(0xFFFF3408), width: 1),
        ),
      ),
      appBarTheme: AppBarTheme.of(context).copyWith(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        toolbarTextStyle: const TextTheme(
          headline6: TextStyle(color: Colors.black, fontSize: 20),
        ).bodyText2,
        titleTextStyle: const TextTheme(
          headline6: TextStyle(color: Colors.black, fontSize: 20),
        ).headline6,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF3F3F3),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
        hintStyle: TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          height: 1.6,
        ),
      ),
      tabBarTheme: Theme.of(context).tabBarTheme.copyWith(
            labelColor: const Color(0xFFFF3408),
            labelStyle: const TextStyle(
              height: 1.0,
              color: Colors.black87,
              fontFamily: 'SF Pro Text',
            ),
            unselectedLabelColor: Colors.black87,
          ),
    );

CupertinoThemeData cupertinoTheme(BuildContext context) =>
    const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.black,
      barBackgroundColor: Colors.black,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: 'SF Pro Text'),
        navTitleTextStyle: TextStyle(fontFamily: 'SF Pro Text'),
      ),
    );
