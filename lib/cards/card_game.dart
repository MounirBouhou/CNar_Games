import 'package:cnargames/models/games.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardGame extends StatelessWidget{
  const CardGame ({
    Key? key,
    required this.games,
    required this.scaffoldKey,
    required this.heroTag
   });

  final Games games;
  final GlobalKey<ScaffoldState> scaffoldKey; // +++++++++++++
  final String heroTag;

  @override
  Widget build(BuildContext context) {

    return InkWell(

      child: Container(

        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryVariant,
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow> [
            BoxShadow(
              color: Colors.grey.shade900
            )
          ]
        ),




        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,    // +++++++++++++
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)
                ),
                child: Hero(
                  tag: heroTag,
                 // child: Text("CustomCacheImage"),
                  child: CustomCacheImage(img: games.image,

                  ),

                ),
              ),
            )

          ],
        ),


      ),


    );



  }
}