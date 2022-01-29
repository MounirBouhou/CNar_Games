import 'dart:ui';

import 'package:cnargames/config/config.dart';
import 'package:cnargames/config/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);
  _NoInternet createState() => _NoInternet();
}

class _NoInternet extends State<NoInternet> {

  @override
  Widget build(BuildContext context) {
  return AnnotatedRegion(
    value: Theme.of(context).brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark,
    child: Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
        padding: EdgeInsets.all(0),
        alignment: Alignment.topCenter,
        //height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Config().netOff,
              fit: BoxFit.fill,
              // alignment: Alignment.topCenter,
              height: 200,
              width: 200,
            ),

            SizedBox(
              height: 20,
            ),

            Text(st.networkIssue,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),

          ],
        ),
    ),
      )
    ),
  );
  }
}
