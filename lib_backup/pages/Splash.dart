import 'dart:async';

import 'package:cnargames/config/config.dart';
import 'package:cnargames/config/strings.dart';
import 'package:cnargames/pages/home.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return AnnotatedRegion(
      value: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                height: 212,
                width: 212,
                image: AssetImage(Config().splash),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 40,),
            Center(child: Text(st.playWithUs, style: TextStyle(fontWeight:FontWeight.w200,fontSize: 20, color: Theme.of(context).iconTheme.color,),),)



          ],
        ),
      ),
    );
  }
}