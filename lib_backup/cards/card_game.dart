import 'dart:ui';

import 'package:cnargames/blocs/games_views.dart';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/pages/play_game.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:cnargames/widgets/bookmark_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class CardGame extends StatelessWidget {
  const CardGame({
    Key? key,
    required this.games,
    required this.scaffoldKey,
    required this.heroTag,
    required this.bgMain,
    required this.bgBox,
  });

  final Games games;
  final GlobalKey<ScaffoldState> scaffoldKey; // +++++++++++++
  final String heroTag;
  final Color bgMain;
  final Color bgBox;

  @override
  Widget build(BuildContext context) {
    final bookmarkedList = Hive.box(Constants.bookmarkTag);
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
              child: Container(
                height: 130,
                color: cColors().darkGray,

                child: Column( //general Column
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, right: 5,left: 5),
                          child: Column( // first Col title and Cat
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                games.title!,
                                maxLines: 2,
                                style: TextStyle(
                                    color: cColors().gray,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                games.category!,
                                style: TextStyle(
                                    color: cColors().gray,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w200),
                              ),
                              //SizedBox(height: 10),
                            ],
                          ),
                        ),
                       // onHover: Colors.yellow,
                          onTap: () {
                            GamesViews().sendViewsCount(heroTag);
                           nextScreen(context, PlayGame(tag: heroTag, gamesData: games));
                          }
                      ),


                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
                        child: Column(
                         children: [
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               BookmarkIcon(
                                 bookmarkedList: bookmarkedList,
                                 games: games,
                                 iconSize: 20,
                                 scaffoldKey: scaffoldKey,
                               ),
                               /////////////////////////////////////////////////////////////
                               Row(
                                 //mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   ClipRRect(
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(8)),
                                     child: Container(
                                       padding: const EdgeInsets.only(
                                           right: 6, left: 6, bottom: 3, top: 3),
                                       color: bgBox,
                                       child: Row(
                                         children: [
                                           Container(
                                             margin: const EdgeInsets.only(
                                                 right: 0.0),
                                             child: games.rate!.length <= 1
                                                 ? Text(
                                               (games.rate!) + "/5",
                                               style: TextStyle(
                                                   fontSize: 12,
                                                   color: Colors
                                                       .grey.shade200),
                                             )
                                                 : Text(
                                               (games.rate!)
                                                   .substring(0, 1) +
                                                   "/5",
                                               style: TextStyle(
                                                   fontSize: 10,
                                                   color: Colors
                                                       .grey.shade200),
                                             ),
                                           ),
                                           SizedBox(
                                             width: 2,
                                           ),
                                           Align(
                                             alignment: Alignment.centerLeft,
                                             child: Icon(
                                               CupertinoIcons.star,
                                               size: 13,
                                               color: cColors().yellowDark,
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                   SizedBox(
                                     width: 3,
                                   ),
                                   ClipRRect(
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(8)),
                                     child: Container(
                                       padding: const EdgeInsets.only(
                                           right: 6, left: 6, bottom: 3, top: 3),
                                       color: bgBox,
                                       child: Row(
                                         children: [
                                           Container(
                                             margin: const EdgeInsets.only(
                                                 right: 0.0),
                                             child: Text(
                                               games.views.toString(),
                                               style: TextStyle(
                                                   fontSize: 10,
                                                   color: Colors.grey.shade200),
                                             ),
                                           ),
                                           SizedBox(
                                             width: 3,
                                           ),
                                           Align(
                                             alignment: Alignment.centerLeft,
                                             child: Icon(
                                               CupertinoIcons.gamecontroller,
                                               size: 13,
                                               color: cColors().blueDark,
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ],
                        ),
                      )
                      // Padding(
                      //   padding: const EdgeInsets.all(8),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       //Text(
                      //       //  HtmlUnescape().convert(games.content!),
                      //       //  overflow: TextOverflow.ellipsis,
                      //       //  maxLines: 2,
                      //       //  style: TextStyle(
                      //       //      color: cColors().gray,
                      //       //      fontSize: 11,
                      //       //      fontWeight: FontWeight.w300),
                      //       //),
                      //       //SizedBox(
                      //       //  height: 10,
                      //       //),
                      //
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
            ),
            ),

          InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                color: cColors().darkGray,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                      color: bgBox,
                      child: CustomCacheImage(
                        img: games.image!,
                        w: 155,
                        h: 150,
                      )),
                ),
              ),
            ),
              onTap: () {
                GamesViews().sendViewsCount(heroTag);
                nextScreen(context, PlayGame(tag: heroTag, gamesData: games));
              }
          )

        ],
      ),
    );
  }
}
