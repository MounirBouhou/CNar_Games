import 'dart:ui';
import 'package:cnargames/Colors/custom_colors.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/pages/play_game.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html_unescape/html_unescape.dart';

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
        child: new Stack(
          children: [

            // box
            Container (
              width: double.infinity,
              height: 170.0,
              margin: new EdgeInsets.only(left: 70.0),

              decoration: new BoxDecoration(
                color: new Color(0xFF222222),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2.0,
                    offset: new Offset(3.0, 3.0),
                  ),
                ],
              ),


              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FractionallySizedBox(
                  widthFactor: 0.66,
                  alignment: Alignment.centerRight,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(games.title!, maxLines: 1, style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 12, fontWeight: FontWeight.w600
                      ),),
                      Text(games.category!, style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 9,  fontWeight: FontWeight.w200
                      ),),
                      SizedBox(height: 8),
                      Text(HtmlUnescape().convert(games.content!),
                        overflow: TextOverflow.ellipsis, maxLines: 3,
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 9, fontWeight: FontWeight.w400
                        ),),
                      SizedBox(height: 15),

                      Row (
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Icon(CupertinoIcons.gamecontroller, size: 14, color: cColors().blue,),
                          SizedBox(width: 4),
                          Text(games.views!, style: TextStyle(fontSize: 12, color: Colors.grey.shade200),),
                          SizedBox(width: 15),
                          Icon(CupertinoIcons.heart, size: 14, color: cColors().pink,),
                          SizedBox(width: 4),
                          Text((games.rate!).substring(0, 3) + "/5", style: TextStyle(fontSize: 12, color: Colors.grey.shade200),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),


            // Image container
            Container(
                alignment: Alignment.centerLeft,
                margin: new EdgeInsets.symmetric(
                    vertical: 10.0,
                ),
                child: Container(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: Hero(
                        tag: heroTag,
                        child: CustomCacheImage(img: games.image,),
                      ),
                    ),
                  ),
                )


            )
          ],
        ),

        onTap: () {
          nextScreen(context, PlayGame(tag: heroTag, gamesData: games));
        }
    );
  }
}