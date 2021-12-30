import 'package:cnargames/models/category.dart';
import 'package:cnargames/utils/colors_list.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardCategory extends StatelessWidget{
  const CardCategory ({
    Key? key,
    required this.cat,
    required this.scaffoldKey,
  });

  final mCategory cat;
  final GlobalKey<ScaffoldState> scaffoldKey; // +++++++++++++

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Positioned(
          left: 5,
          top: 20,
          child: Container(
            width: 90,
            height: 88,
            child: Card(
              color: getRanColors(),
              elevation: 3,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
            ),
        ),

             Container(
              //color: cColors().gray,
              width: 100,
              child: Center(
                  child: CustomCacheImage(
                img: cat.thumb,
              )),
            ),


      ]
    );
  }
  }

Color? getRanColors(){
return (ColorList().RandomColors..shuffle()).first;
}