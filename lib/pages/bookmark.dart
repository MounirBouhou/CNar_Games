import 'package:cnargames/cards/card_bookmark.dart';
import 'package:cnargames/cards/constants.dart';
import 'package:cnargames/config/config.dart';
import 'package:cnargames/config/strings.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/services/bookmark_service.dart';
import 'package:cnargames/utils/empty_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  _BookmarkTabState createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<Bookmark> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bookmarkList = Hive.box(Constants.bookmarkTag);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnnotatedRegion(
        value: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: Scaffold(
          appBar: AppBar(
            title: Text(st.favorite,
            ),
            iconTheme: IconThemeData(
              //color: cColors().pinkDark, //change your color here
            ),
            actions: [
              bookmarkList.isNotEmpty ?
              Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: IconButton(
                    onPressed: () => BookmarkService().clearBookmarkList(),
                    icon: Icon(
                      CupertinoIcons.delete_simple,
                    ),
                  )) :
                  Text('')
            ],
          ),


          body: Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: bookmarkList.listenable(),
                      builder: (BuildContext context, dynamic value, Widget? child) {
                        if(bookmarkList.isEmpty) return EmptyPageWithImage(
                          image: Config().emptyBkm,
                          title: st.noGameInTheFavorites,
                          description: st.saveYourFavoriteGamesHere,
                        );

                        return GridView.builder(
                         // physics: NeverScrollableScrollPhysics(), // important
                          padding: EdgeInsets.only(left: 12, right: 12),
                          shrinkWrap: true, //important
                          itemCount: bookmarkList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Games games = Games(
                                       id: bookmarkList.getAt(index)['id'],
                                       title: bookmarkList.getAt(index)['title'],
                                       //content: bookmarkList.getAt(index)['content'],
                                       image: bookmarkList.getAt(index)['image'],
                                       category: bookmarkList.getAt(index)['category'],
                                       views: bookmarkList.getAt(index)['views'],
                                       rate: bookmarkList.getAt(index)['rate'],
                                       game: bookmarkList.getAt(index)['game'],
                                       height: bookmarkList.getAt(index)['height'],
                                       width: bookmarkList.getAt(index)['width'],
                                       date: bookmarkList.getAt(index)['date'],
                                       catId: bookmarkList.getAt(index)['catId']);

                                   return BookmarkCard(article: games);
                            // if (index == 0 && index != 0){
                            //   return BannerAD();
                            // }
                            // return CardGame(
                            //   heroTag: '${g.id}',
                            //   scaffoldKey: scaffoldKey,
                            //   games: g,
                            //   bgMain: cColors().darkGray,
                            //   bgBox: cColors().black22,
                            // );
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
                              mainAxisSpacing: 15,
                              childAspectRatio: 2.71),
                        );







                        //   ListView.separated(
                        //   padding: EdgeInsets.all(15),
                        //   itemCount: bookmarkList.length,
                        //   separatorBuilder: (context, index) => SizedBox(
                        //     height: 15,
                        //   ),
                        //   itemBuilder: (BuildContext context, int index) {
                        //     Games games = Games(
                        //         id: bookmarkList.getAt(index)['id'],
                        //         title: bookmarkList.getAt(index)['title'],
                        //         //content: bookmarkList.getAt(index)['content'],
                        //         image: bookmarkList.getAt(index)['image'],
                        //         category: bookmarkList.getAt(index)['category'],
                        //         views: bookmarkList.getAt(index)['views'],
                        //         rate: bookmarkList.getAt(index)['rate'],
                        //         game: bookmarkList.getAt(index)['game'],
                        //         height: bookmarkList.getAt(index)['height'],
                        //         width: bookmarkList.getAt(index)['width'],
                        //         date: bookmarkList.getAt(index)['date'],
                        //         catId: bookmarkList.getAt(index)['catId']);
                        //
                        //     return BookmarkCard(article: games);
                        //   },
                        // );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


