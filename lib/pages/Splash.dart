import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/config.dart';
import 'package:cnargames/pages/home.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget{
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{

  Future _afterSplash() async {
    Future.delayed(Duration(milliseconds: 1500)).then((value) => _goToHomePage());
  }

  void _goToHomePage() {
    nextScreenReplace(context, Home());
  }

  @override
  void initState() {
    super.initState();
    _afterSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cColors().bg,
      body: Center(
        child: Image(
          height: 212,
          width: 212,
          image: AssetImage(Config().splash),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}