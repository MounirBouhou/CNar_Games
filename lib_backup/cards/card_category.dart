import 'package:cnargames/models/category.dart';
import 'package:cnargames/utils/colors_list.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
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
        Center(
          child: Container(
            width: 68,
            height: 80,
            child: Card(
              color: getRanColors(),
              elevation: 0,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            ),
        ),

             Center(
                 child: CustomCacheImage(
               img: cat.thumb, w: 70, h: 70,
             )),


      ]
    );
  }
  }

Color? getRanColors(){
return (ColorList().RandomColors..shuffle()).first;
}