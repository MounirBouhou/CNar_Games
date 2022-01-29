import 'package:carousel_slider/carousel_slider.dart';
import 'package:cnargames/cards/card_game.dart';
import 'package:cnargames/cards/featured_card_game.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/strings.dart';
import 'package:cnargames/models/featured_games.dart';
import 'package:cnargames/models/games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading.dart';

class LastGames extends StatelessWidget {
  final List<Games> gamz;
  final List<FeaturedGames> fgames;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LastGames(
      {Key? key,
      required this.gamz,
      required this.fgames,
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
        gamz.isEmpty || fgames.isEmpty
            ? loading(context)
            : Column(
                children: [
                  /** Categories icons **/
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      ListTile(
                        //tileColor: cColors().yellow,
                        //contentPadding: EdgeInsets.only(right: 12, left: 12),
                        leading: Container(
                          //alignment: Alignment.center,
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              CupertinoIcons.flame,
                              size: 24,
                              color: Theme.of(context).iconTheme.color,
                            )),
                        horizontalTitleGap: 0,
                        enabled: false,
                        title: Text(st.featuredGames,
                          style: Theme.of(context).textTheme.headline1
                        ),
                      ),

                      SizedBox(height: 15,),

                      CarouselSlider.builder(
                        itemCount: fgames.length,
                        options: CarouselOptions(
                          aspectRatio: 1.8,
                          enlargeCenterPage: true,
                          autoPlay: false,
                        ),
                        itemBuilder: (ctx, index, realIdx) {
                          var a = fgames[index];

                          return FeaturedCardGames(
                            heroTag: '${a.id}',
                            thumb: '${a.imageFeatured}',
                            scaffoldKey: scaffoldKey,
                            fgames: a,
                            // bgMain: cColors().darkGray,
                            // bgBox: cColors().black22,
                          );
                          //   Container(
                          //   child: Text('${a.category}'),
                          // );
                        },
                      ),
                    ],
                  ),
                  // CarouselSlider(
                  // options: CarouselOptions(),
                  // items: gamz.map((item) => Container(
                  // child: Center(child: Text(item.toString())),
                  // color: Colors.green,
                  // )).toList(),
                  // ),

                  // CarouselSlider(
                  //   options: CarouselOptions(
                  //     autoPlay: true,
                  //     aspectRatio: 2.0,
                  //     enlargeCenterPage: true,
                  //   ),
                  //   items: ,
                  // ),

                  /** Banner Ad **/
                  //  Center(child: BannerAD()),

                  /** Games **/
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: [
                        ListTile(
                          //tileColor: cColors().yellow,
                          //contentPadding: EdgeInsets.only(right: 12, left: 12),
                          leading: Container(
                              //alignment: Alignment.center,
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                CupertinoIcons.gamecontroller,
                                size: 24,
                                color: Theme.of(context).iconTheme.color,
                              )),
                          horizontalTitleGap: 0,
                          enabled: false,
                          title: Text(st.newGames,
                            style: Theme.of(context).textTheme.headline1
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            // AppService().openLinkWithCustomTab(context, WpConfig().websiteUrl);
                          },
                        ),
                        // Divider(
                        //   color: cColors().pinkDark,
                        //   thickness: 1,
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(), // important
                          padding: EdgeInsets.only(left: 12, right: 12),
                          shrinkWrap: true, //important
                          itemCount: gamz.length,
                          itemBuilder: (BuildContext context, int index) {
                            var g = gamz[index];
                            // if (index == 0 && index != 0){
                            //   return BannerAD();
                            // }
                            return CardGame(
                              heroTag: '${g.id}',
                              scaffoldKey: scaffoldKey,
                              games: g,
                              bgMain: cColors().darkGray,
                              bgBox: cColors().black22,
                            );
                          },
                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 2,
                          //   crossAxisSpacing: 12.0,
                          //   mainAxisSpacing: 0,
                          // ),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 400,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 2.1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
