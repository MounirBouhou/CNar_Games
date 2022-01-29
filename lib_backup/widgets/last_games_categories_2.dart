import 'package:cnargames/blocs/category_games.dart';
import 'package:cnargames/cards/card_category.dart';
import 'package:cnargames/models/category.dart';
import 'package:cnargames/pages/category_based_games.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class LastCategories2 extends StatelessWidget {
  final List<mCategory> catz;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LastCategories2(
      {Key? key,
        required this.catz,
        required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width - 2;

    return catz.isEmpty
        ? ClipRRect(
      // show only empty squares, basically is like a loading
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 11.0, horizontal: 8.0),
        height: 100,
        width: itemWidth,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Stack(
                  children:[
                    Container(
                      width: 68,
                      height: 80,
                      child: Card(
                        //color: getRanColors(),
                       // color: cColors().bg,
                        elevation: 0,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),

                    //Center(
                    //    child: CustomCacheImage(
                    //      img: cat.thumb, w: 70, h: 70,
                    //    )),

                  ]
              );
            }),
      ),
    )
        : ClipRRect(
      // show the cat images
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 11.0, horizontal: 8.0),
        height: 100,
        width: itemWidth,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: catz.length,
            itemBuilder: (context, index) {
              var mc = catz[index];
              return InkWell(
                  child: CardCategory(
                    cat: mc,
                    // heroTag: '${mc.id}',
                    scaffoldKey: scaffoldKey,
                  ),
                  onTap: () {
                    nextScreenReplace(
                        context,
                        CategoryBasedGames(
                            catName: catz[index].name,
                            //catId: catz[index].id,
                            catThumb: catz[index].thumb));
                            context.read<CategoryGamesBloc>().setScroll(false);
                            context.read<CategoryGamesBloc>().catID('${catz[index].id}');
                  });
            }),
      ),
    );
    
    // Column(
    //   children: [
    //     /** Categories icons **/
    //     Padding(
    //       padding: const EdgeInsets.only(top: 25, bottom: 25),
    //       child: Column(children: [
    //         ListTile(
    //           //tileColor: cColors().yellow,
    //           // trailing: InkWell(
    //           //   child: Icon(
    //           //     CupertinoIcons.arrow_left,
    //           //     size: 22,
    //           //     color: cColors().gray,
    //           //   ),
    //           //   onTap: () {},
    //           // ),
    //
    //           leading: Container(
    //             //alignment: Alignment.center,
    //               padding: EdgeInsets.all(8),
    //               decoration: new BoxDecoration(
    //                 color: cColors().pinkDark,
    //                 shape: BoxShape.circle,
    //                 // borderRadius: new BorderRadius.all(Radius.circular(100)),
    //               ),
    //               child: Icon(
    //                 CupertinoIcons
    //                     .square_fill_line_vertical_square_fill,
    //                 size: 26,
    //                 color: cColors().gray,
    //               )),
    //           horizontalTitleGap: 12,
    //           enabled: false,
    //           title: Text(
    //             'تصنيفات',
    //             style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w500,
    //                 color: cColors().pinkDark),
    //           ),
    //         ),
    //         Divider(
    //           color: cColors().pinkDark,
    //           thickness: 1,
    //           indent: 20,
    //           endIndent: 20,
    //         ),
    //         ClipRRect(
    //           borderRadius: BorderRadius.all(Radius.circular(5)),
    //           child: Container(
    //             padding: EdgeInsets.symmetric(
    //                 vertical: 5.0, horizontal: 10.0),
    //             height: 115,
    //             child: ListView.builder(
    //                 scrollDirection: Axis.horizontal,
    //                 itemCount: catz.length,
    //                 itemBuilder: (context, index) {
    //                   var mc = catz[index];
    //                   return InkWell(
    //                       child: CardCategory(
    //                         cat: mc,
    //                         // heroTag: '${mc.id}',
    //                         scaffoldKey: scaffoldKey,
    //                       ),
    //                       onTap: () {
    //                         nextScreen(
    //                             context,
    //                             CategoryBasedGames(
    //                                 catName: catz[index].name,
    //                                 catId: catz[index].id,
    //                                 catThumb: catz[index].thumb));
    //                       });
    //                 }),
    //           ),
    //         ),
    //       ]),
    //     ),
    //
    //
    //     /** Banner Ad **/
    //     //  Center(child: BannerAD()),
    //
    //     /** Games **/
    //     Padding(
    //       padding: const EdgeInsets.only(top: 25, bottom: 25),
    //       child: Column(
    //         children: [
    //           ListTile(
    //             //tileColor: cColors().yellow,
    //             //contentPadding: EdgeInsets.only(right: 12, left: 12),
    //             leading: Container(
    //               //alignment: Alignment.center,
    //                 padding: EdgeInsets.all(8),
    //                 decoration: new BoxDecoration(
    //                   color: cColors().pinkDark,
    //                   shape: BoxShape.circle,
    //                   // borderRadius: new BorderRadius.all(Radius.circular(100)),
    //                 ),
    //                 child: Icon(
    //                   CupertinoIcons.game_controller_solid,
    //                   size: 26,
    //                   color: cColors().gray,
    //                 )),
    //             horizontalTitleGap: 12,
    //             enabled: false,
    //             title: Text(
    //               'جديد الألعاب',
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.w500,
    //                   color: cColors().pinkDark),
    //             ),
    //             onTap: () {
    //               Navigator.pop(context);
    //               // AppService().openLinkWithCustomTab(context, WpConfig().websiteUrl);
    //             },
    //           ),
    //           Divider(
    //             color: cColors().pinkDark,
    //             thickness: 1,
    //             indent: 20,
    //             endIndent: 20,
    //           ),
    //
    //           // GridView.builder(
    //           //   physics: NeverScrollableScrollPhysics(), // important
    //           //   padding: EdgeInsets.all(12),
    //           //   shrinkWrap: true, //important
    //           //   itemCount: gamz.length,
    //           //   itemBuilder: (BuildContext context, int index) {
    //           //     var g = gamz[index];
    //           //     // if (index == 0 && index != 0){
    //           //     //   return BannerAD();
    //           //     // }
    //           //     return CardGame(
    //           //       heroTag: '${g.id}',
    //           //       scaffoldKey: scaffoldKey,
    //           //       games: g, bgMain: cColors().darkGray,
    //           //       bgBox: cColors().black22,
    //           //     );
    //           //   },
    //           //   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           //   //   crossAxisCount: 2,
    //           //   //   crossAxisSpacing: 12.0,
    //           //   //   mainAxisSpacing: 0,
    //           //   // ),
    //           //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //           //       maxCrossAxisExtent: 360,
    //           //       crossAxisSpacing: 12,
    //           //       mainAxisSpacing: 10,
    //           //       childAspectRatio: 1.1
    //           //   ),
    //           // ),
    //         ],
    //       ),
    //     ),
    //   ],
    //
    // ),
      ;

  }
}
