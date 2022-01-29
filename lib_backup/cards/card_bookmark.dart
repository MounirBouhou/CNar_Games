import 'package:cnargames/blocs/games_views.dart';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/pages/play_game.dart';
import 'package:cnargames/services/bookmark_service.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';


class BookmarkCard extends StatelessWidget {
  final Games article;
  const BookmarkCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String heroTag = '${article.id}';
    return InkWell(
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: cColors().darkGray,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 110,
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: cColors().gray,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),

                          ),
                          Text(
                            article.category!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: cColors().gray,
                                fontSize: 10,
                                fontWeight: FontWeight.w200),

                          ),
                        ],
                      ),

                      IconButton(
                          icon: Icon(Icons.highlight_remove_sharp,),
                          onPressed: () => BookmarkService()
                              .removeFromBookmarkList(article)),

                    ],
                  ),
                ),
              ),


              ////////////////////////////////////// image
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  height: 110,
                  width: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Hero(
                        tag: heroTag,
                        child: CustomCacheImage(img: article.image, w: 200, h: 260,)),
                  ),
                ),
              ),
            ],
          )),
      onTap: (){
        GamesViews().sendViewsCount(heroTag);
        nextScreen(context, PlayGame( gamesData: article));
      },
    );
  }

}