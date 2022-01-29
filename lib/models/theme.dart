
import 'package:cnargames/colors/custom_colors.dart';
import 'package:flutter/material.dart';


class ThemeModel {



  

  final lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
   //primarySwatch: Colors.lightBlue,//
   //primaryColor: Config().appThemeColor,
   //accentColor: Colors.pinkAccent,
    backgroundColor: cColors().gray, //
    scaffoldBackgroundColor: cColors().bg, //
    shadowColor: Colors.transparent,
    brightness: Brightness.light,
    fontFamily: 'Cairo',
   colorScheme: ColorScheme.light(
       primary: cColors().pinkDark, //text
       secondary: cColors().black22, //text
       // onPrimary: Colors.greenAccent, //card color -1
       // onSecondary: Colors.white, //card color -2
       // primaryVariant: Colors.yellowAccent, //card color -3
       // secondaryVariant: Colors.orangeAccent, //card color -4
       // surface: Color(0xFFA87233), //shadow color - 1
       // onBackground: Colors.lightBlueAccent  //loading card color

       ),
   // dividerColor:cColors().blueDark,
    iconTheme: IconThemeData(color:cColors().pinkDark),
    primaryIconTheme: IconThemeData( //
      color: cColors().gray,//
    ),

    textTheme: TextTheme(
      // LisTile Home
        headline1: TextStyle( // ListTile home
            fontSize: 17,
            fontWeight: FontWeight.w300,
            color: cColors().pinkDark),

        // Drawer Text
        headline2: TextStyle( // ListTile home
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: cColors().black22),

        // load more text
        headline3: TextStyle( // ListTile home
            fontSize: 20,
            fontWeight: FontWeight.w300,
        color: cColors().pinkDark)//
    ),


    appBarTheme: AppBarTheme(
        color: cColors().bg, //
        elevation: 0,//
        centerTitle: true, //
        titleTextStyle: TextStyle( //
          fontFamily: 'Cairo',
           fontWeight: FontWeight.w600,
          color: cColors().pinkDark,
            fontSize: 18
        ),
        // textTheme: TextTheme(
        //     headline6: TextStyle(
        //         fontFamily: 'Cairo',
        //         fontSize: 18,
        //         fontWeight: FontWeight.w600,
        //         letterSpacing: -0.7,
        //         color: cColors().blueDark)//
        // ),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: cColors().pinkDark, size: 30.0),
        //systemOverlayStyle: SystemUiOverlayStyle.light //
    ),


    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: cColors().blueDark,
    //   selectedItemColor: Colors.white,
    //   unselectedItemColor: Colors.grey[500],
    // ),

  //   popupMenuTheme: PopupMenuThemeData(
  //     textStyle: TextStyle(
  //       fontFamily: 'Cairo',
  //       color: Colors.white,
  //       fontWeight: FontWeight.w500
  //     ),
  //   ),
   );




  final darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
   //primarySwatch: Colors.lightBlue,//
   //primaryColor: Config().appThemeColor,
   //accentColor: Colors.pinkAccent,
    backgroundColor: cColors().gray, //
    scaffoldBackgroundColor: cColors().black22, //
    shadowColor: Colors.transparent,
    brightness: Brightness.dark,
    fontFamily: 'Cairo',
   colorScheme: ColorScheme.dark(
       primary: cColors().blueDark, //text
       secondary: cColors().bg, //text
       // onPrimary: Colors.greenAccent, //card color -1
       // onSecondary: Colors.white, //card color -2
       // primaryVariant: Colors.yellowAccent, //card color -3
       // secondaryVariant: Colors.orangeAccent, //card color -4
       // surface: Color(0xFFA87233), //shadow color - 1
       // onBackground: Colors.lightBlueAccent  //loading card color

       ),
   // dividerColor:cColors().blueDark,
    iconTheme: IconThemeData(color:cColors().blueDark),
    primaryIconTheme: IconThemeData( //
      color: cColors().gray,//
    ),

    textTheme: TextTheme(
      // LisTile Home
        headline1: TextStyle( // ListTile home
            fontSize: 17,
            fontWeight: FontWeight.w300,
            color: cColors().blueDark),

        // Drawer Text
        headline2: TextStyle( // ListTile home
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: cColors().bg),

        // load more text
        headline3: TextStyle( // ListTile home
            fontSize: 20,
            fontWeight: FontWeight.w300,
        color: cColors().blueDark)//
    ),


    appBarTheme: AppBarTheme(
        color: cColors().black22, //
        elevation: 0,//
        centerTitle: true, //
        titleTextStyle: TextStyle( //
          fontFamily: 'Cairo',
           fontWeight: FontWeight.w600,
          color: cColors().blueDark,
            fontSize: 18
        ),
        // textTheme: TextTheme(
        //     headline6: TextStyle(
        //         fontFamily: 'Cairo',
        //         fontSize: 18,
        //         fontWeight: FontWeight.w600,
        //         letterSpacing: -0.7,
        //         color: cColors().blueDark)//
        // ),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: cColors().blueDark, size: 30.0),
        //systemOverlayStyle: SystemUiOverlayStyle.light //
    ),


    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: cColors().blueDark,
    //   selectedItemColor: Colors.white,
    //   unselectedItemColor: Colors.grey[500],
    // ),

  //   popupMenuTheme: PopupMenuThemeData(
  //     textStyle: TextStyle(
  //       fontFamily: 'Cairo',
  //       color: Colors.white,
  //       fontWeight: FontWeight.w500
  //     ),
  //   ),
   );
}
