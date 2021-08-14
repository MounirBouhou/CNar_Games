
import 'package:cnargames/colors/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loading(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: cColors().gray, backgroundColor: cColors().pinkDark, strokeWidth: 2),
        SizedBox(height: 15,),
        Text("جار التحميل...",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: cColors().gray
          ),),
      ],
    ),
  );
}