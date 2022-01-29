// import 'package:cnargames/cards/card_category.dart';
// import 'package:cnargames/models/category.dart';
// import 'package:cnargames/pages/category_based_games.dart';
// import 'package:cnargames/utils/next_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'loading.dart';
//
// class CatBottom extends StatelessWidget {
//   final List<mCategory> catz;
//   final GlobalKey<ScaffoldState> scaffoldKey;
//
//   const CatBottom(
//       {Key? key,
//         required this.catz,
//         required this.scaffoldKey})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final double itemHeight = (size.height) / 2;
//     final double itemWidth = size.width / 2;
//
//     return catz.isEmpty
//        ? loading(context)
//        :
//        /** Categories icons **/
//        Padding(
//          padding: const EdgeInsets.only(top: 25, bottom: 25),
//          child: Column(children: [
//            ClipRRect(
//              borderRadius: BorderRadius.all(Radius.circular(5)),
//              child: Container(
//                padding: EdgeInsets.symmetric(
//                    vertical: 5.0, horizontal: 10.0),
//                height: 115,
//                child: ListView.builder(
//                    scrollDirection: Axis.horizontal,
//                    itemCount: catz.length,
//                    itemBuilder: (context, index) {
//                      var mc = catz[index];
//                      return InkWell(
//                          child: CardCategory(
//                            cat: mc,
//                            // heroTag: '${mc.id}',
//                            scaffoldKey: scaffoldKey,
//                          ),
//                          onTap: () {
//                            nextScreen(
//                                context,
//                                CategoryBasedGames(
//                                    catName: catz[index].name,
//                                    catId: catz[index].id,
//                                    catThumb: catz[index].thumb));
//                          });
//                    }),
//              ),
//            ),
//          ]),
//        );
//
//
//        /** Banner Ad **/
//        //  Center(child: BannerAD()),
//
//        /** Games **/
//
//
//   }
// }
