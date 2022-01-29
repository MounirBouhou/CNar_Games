import 'package:cnargames/colors/custom_colors.dart';
import 'package:flutter/material.dart';

void openSnacbar(scaffoldKey, snackMessage, ic){
  scaffoldKey.currentState.showSnackBar(
        SnackBar( duration: Duration(seconds: 3),
        backgroundColor: cColors().darkGray,
        content:
        Directionality(
          textDirection: TextDirection.rtl,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(snackMessage, style: TextStyle(fontFamily: 'Cairo',fontSize: 16, color: cColors().gray)),
                   Icon(ic, size: 25, color: cColors().gray,),
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