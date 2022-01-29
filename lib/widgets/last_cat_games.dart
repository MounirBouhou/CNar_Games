import 'package:carousel_slider/carousel_slider.dart';
import 'package:cnargames/blocs/category_games.dart';
import 'package:cnargames/cards/card_game.dart';
import 'package:cnargames/cards/featured_card_game.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/strings.dart';
import 'package:cnargames/models/featured_games.dart';
import 'package:cnargames/models/games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'cat_loading.dart';
import 'loading.dart';

class LastCatGames extends StatelessWidget {
  final List<Games> cgamz;
  final String? catThumb;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LastCatGames(
      {Key? key,
      required this.cgamz,
      required this.catThumb,
      required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cgamz.isEmpty
      ? CatLoading(
          catThumb: catThumb,
          scaffoldKey: scaffoldKey)
      : GridView.builder(
          physics: NeverScrollableScrollPhysics(), // important
          padding: EdgeInsets.all(12),
          shrinkWrap: true, //important
          itemCount: context.watch<CategoryGamesBloc>().games.length,
          itemBuilder:
              (BuildContext context, int index) {
            var g = context.watch<CategoryGamesBloc>().games[index];
            // if (index == 0 && index != 0){
            //   return BannerAD();
            // }
            return CardGame(
              heroTag: '${g.id}',
              scaffoldKey: scaffoldKey,
              games: g,
              bgMain: cColors().pinkDark,
              bgBox: cColors().black30,
            );
          },
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          //   crossAxisSpacing: 12.0,
          //   mainAxisSpacing: 0,
          // ),
          gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 480,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.1),
        ),
      ],
    );
  }
}
