import 'dart:ui';

import 'package:cnargames/blocs/games_views.dart';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/models/featured_games.dart';
import 'package:cnargames/pages/play_game_featured.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FeaturedCardGames extends StatelessWidget {
  const FeaturedCardGames({
    Key? key,
    required this.fgames,
    required this.thumb,
    required this.scaffoldKey,
    required this.heroTag,
    // required this.bgMain,
    // required this.bgBox,
  });

  final FeaturedGames fgames;
  final GlobalKey<ScaffoldState> scaffoldKey; // +++++++++++++
  final String heroTag;
  final String thumb;
  // final Color bgMain;
  // final Color bgBox;

  @override
  Widget build(BuildContext context) {
    //final bookmarkedList = Hive.box(Constants.bookmarkTag);
    return
      InkWell(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Container(
                color: cColors().noir,
                child: CustomCacheImage(
                  img: thumb,
                  w: double.infinity,
                  h: 200,
                )),
          ),
        ),
        onTap: () {
          GamesViews().sendViewsCount(heroTag);
          nextScreen(context, PlayGameFeatured(tag: heroTag, gamesData: fgames));
        });
  }
}
