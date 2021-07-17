import 'dart:ui';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);
  _NoInternet createState() => _NoInternet();
}

class _NoInternet extends State<NoInternet> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: <Widget>[
          // Max Size
          Center(
            child: Container(
              alignment: Alignment.center,
              color: cColors().pinkDark,
              child: Text("هناك مشكلة في الشبكة!", style: TextStyle(
                color: cColors().gray,
                fontSize: 22, fontWeight: FontWeight.w700
            ),),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                "assets/images/noNet.png",
                fit: BoxFit.fitWidth,
                width: 150,
                alignment: Alignment.bottomLeft,
              ),
            ),
          )
        ],
      ),
    ),
  );
  }
}
