import 'package:cnargames/config/strings.dart';
import 'package:cnargames/utils/gif_loading_list.dart';
import 'package:flutter/material.dart';

Widget loading(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height - 210,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        SizedBox(height: 8),
        Text(st.loading,
          style: Theme.of(context).textTheme.headline3,),
      ],
    ),
  );
}

getRanGif() {
  return (gifList().RandomGif..shuffle()).last;
}