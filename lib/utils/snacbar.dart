import 'package:cnargames/colors/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void openSnacbar(scaffoldKey, snackMessage, bColor, ic){
  scaffoldKey.currentState.showSnackBar(
        SnackBar( backgroundColor: bColor, duration: Duration(seconds: 3),
        content:
        Directionality(
          textDirection: TextDirection.rtl,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(snackMessage, style: TextStyle(fontSize: 20, color: cColors().gray)),
                   Icon(ic, size: 30, color: cColors().gray,),
                 ],
            ),
            ),
            //action: SnackBarAction(
            //// this.textColor,
            //// this.disabledTextColor,
            //// required this.label,
            //// required this.onPressed,
            //label: 'OK',
            //textColor: Colors.lightBlue,
            //onPressed: () { },
            //),
        ),
  );
}