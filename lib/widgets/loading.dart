
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/utils/gif_loading_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loading(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height - 60,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //CircularProgressIndicator(color: cColors().gray, backgroundColor: cColors().pinkDark, strokeWidth: 2),
        // Container(
        //     width: 190.0,
        //     height: 190.0,
        //     decoration: new BoxDecoration(
        //         shape: BoxShape.circle,
        //         image: getRanGif()
        //     )),

         ClipRRect(
          borderRadius: BorderRadius.circular(50),
           child: Opacity(
             opacity: 0.6,
             child: Image(
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                image: AssetImage(
                   getRanGif()
                ),
                ),
           ),
         ),

        SizedBox(height: 15,),
        Text("جار التحميل...",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: cColors().pinkDark,
          ),),
      ],
    ),
  );
}

getRanGif() {
  return (gifList().RandomGif..shuffle()).last;
}