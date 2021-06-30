import 'package:flutter/material.dart';

void openSnacbar(scaffoldKey, snackMessage){
  scaffoldKey.currentState.showSnackBar(
      SnackBar(
    // Key? key,
    // required this.content,
    // this.backgroundColor,
    // this.elevation,
    // this.margin,
    // this.padding,
    // this.width,
    // this.shape,
    // this.behavior,
    // this.action,
    // this.duration = _snackBarDisplayDuration,
    // this.animation,
    // this.onVisible,
    duration: Duration(seconds: 2),
    content: Container(
      alignment: Alignment.centerLeft,
      height: 60,
      child: Text(snackMessage, style: TextStyle(fontSize: 14),
    ),
  ),
  action: SnackBarAction(
  // this.textColor,
  // this.disabledTextColor,
  // required this.label,
  // required this.onPressed,
  label: 'OK',
  textColor: Colors.lightBlue,
  onPressed: () {  },


  ),));


}