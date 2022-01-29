import 'dart:convert';
import 'dart:io';
import 'package:cnargames/blocs/ad_bloc.dart';
import 'package:cnargames/blocs/category_bloc.dart';
import 'package:cnargames/blocs/category_games.dart';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/cards/card_game.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/strings.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/pages/play_game.dart';
import 'package:cnargames/services/connectivity_provider.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:cnargames/utils/scroll_to_top.dart';
import 'package:cnargames/utils/snacbar.dart';
import 'package:cnargames/widgets/cat_loading.dart';
import 'package:cnargames/widgets/drawer.dart';
import 'package:cnargames/widgets/last_cat_games.dart';
import 'package:cnargames/widgets/last_games_categories_2.dart';
import 'package:cnargames/widgets/load_more.dart';
import 'package:cnargames/widgets/no_internet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'bookmark.dart';

class CategoryBasedGames extends StatefulWidget {
  final String? catName;
  //final int? catId;
  final String? catThumb;

  CategoryBasedGames(
      {Key? key,
      required this.catName,
      //required this.catId,
      required this.catThumb
      })
      : super(key: key);

  @override
  _CategoryBasedGamesState createState() => _CategoryBasedGamesState();
}

class _CategoryBasedGamesState extends State<CategoryBasedGames> {
  ScrollController? _controller;
  Future? getCc;
  Future? getCGg;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    context.read<CategoryGamesBloc>().clearGames(); // important
    getCGg = context.read<CategoryGamesBloc>().getCatGames();

    Future.delayed(Duration(milliseconds: 0))
        .then((value) => context.read<AdsBloc>().showRewardedAd());

    // Scroller
    _controller =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    _controller!.addListener((_scrollListener));
  }

  _scrollListener() async {
    var isEnd = _controller!.offset >= _controller!.position.maxScrollExtent &&
        !_controller!.position.outOfRange;
    if (context.read<CategoryGamesBloc>().games.isNotEmpty && isEnd) {

      context.read<CategoryGamesBloc>().pageIncrement();
      context.read<CategoryGamesBloc>().setLoading(true);
      context.read<CategoryGamesBloc>().setScroll(true);
      await context.read<CategoryGamesBloc>().getCatGames().then((value) {
        context.read<CategoryGamesBloc>().setLoading(false);
      });
    } else {
      //context.read<NewGamesBloc>().setScroll(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  // Future fetchCatGames(int page) async {
  //   try {
  //     var response = await http.get(Uri.parse(
  //         "${WpConfig().webURL}/wp-json/wp/v2/posts?categories[]=" +
  //             widget.catId.toString() +
  //             "&page=$page&tags=1126&per_page=$_postAmount&_fields=id,date,title,content,custom,link"));
  //
  //     if (this.mounted) {
  //       if (response.statusCode == 200) {
  //         List? decodedData = jsonDecode(response.body);
  //         setState(() {
  //           _games.addAll(decodedData!.map((e) => Games.fromJson(e)).toList());
  //           if (_games.length == 0) {
  //             //_hasData = false;
  //           }
  //         });
  //       }
  //     }
  //   } on SocketException {
  //     throw 'No internet connection';
  //   }
  // } // fetchCatGames


  // _scrollListener() async {
  //   var isEnd = _controller!.offset >= _controller!.position.maxScrollExtent &&
  //       !_controller!.position.outOfRange;
  //   if (isEnd) {
  //     print('end + ${isEnd}');
  //     setState(() {
  //       page += 1;
  //       _loading = true;
  //     });
  //     await fetchCatGames(page).then((value) {
  //       setState(() {
  //         _showBackToTopButton = true;
  //         _loading = false;
  //       });
  //     });
  //   } else {
  //     _showBackToTopButton = false;
  //     print('not end');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (c, model, child) {
      if (model.isOnline) {
        return AnnotatedRegion(
          value: Theme.of(context).brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Stack(
            children: [
              Scaffold(
                  key: scaffoldKey,
                  endDrawer: CustomDrawer(),

                  body: RefreshIndicator(
                    onRefresh: () async => await _onRefresh(),
                    child: CustomScrollView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        controller: _controller,
                        slivers: <Widget>[
                          SliverAppBar(
                              title: FittedBox(
                                  fit: BoxFit.fitWidth, child: Text(widget.catName.toString())),
                              // leading: Center(
                              //   child: Padding(
                              //       padding: EdgeInsets.all(6),
                              //       child: Image(
                              //         height: 100,
                              //         width: 100,
                              //         fit: BoxFit.contain,
                              //         image: AssetImage(widget.catThumb),
                              //       )),
                              // ),
                              leading: CustomCacheImage(img: widget.catThumb, w: 80, h: 80,),
                              actions: <Widget>[
                                IconButton(
                                  onPressed: () => nextScreen(context, Bookmark()),
                                  icon: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.favorite_outline_sharp,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      scaffoldKey.currentState!.openEndDrawer(),
                                  icon: Icon(
                                    Icons.menu,
                                  ),
                                ),
                                // IconButton(
                                //     onPressed: () =>
                                //         setState((){
                                //           isOpen = !isOpen;
                                //         }),
                                //     icon: isOpen? Icon(
                                //       Icons.arrow_drop_down_circle_outlined,
                                //       color: cColors().pinkDark,
                                //       size: 30.0,
                                //     ) : Center(
                                //       child: Icon(
                                //         Icons.arrow_drop_down_circle_outlined,
                                //         color: cColors().pinkDark,
                                //         size: 30.0,
                                //       ),
                                //     )
                                // )
                              ],
                              pinned: true,
                              floating: false,
                              expandedHeight: 156.0,
                              flexibleSpace: Directionality(
                                textDirection: TextDirection.rtl,
                                child: FlexibleSpaceBar(
                                  background: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        //color: cColors().gray,
                                        child: FutureBuilder(
                                            future: getCc,
                                            builder: (BuildContext c,
                                                AsyncSnapshot<dynamic> snapshot) {
                                              switch (snapshot.connectionState) {
                                                default:
                                                  if (snapshot.hasError)
                                                    return Text('');
                                                  else
                                                    return LastCategories2(
                                                        catz: context.watch<CategoryBloc>().cat,
                                                        scaffoldKey: scaffoldKey);
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: new FutureBuilder(
                                        future: getCGg,
                                        builder: (BuildContext c, AsyncSnapshot<dynamic> snapshot) {
                                          switch (snapshot.connectionState) {

                                            default:
                                              if (snapshot.hasError)
                                                return Center(
                                                  child: Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: MediaQuery.of(context).size.height - 60,
                                                      child: Center(child: Text(st.networkIssue))),
                                                );

                                              else
                                                return
                                                  Column(
                                                    children: [
                                                      LastCatGames(
                                                          catThumb: widget.catThumb,
                                                          cgamz: context.watch<CategoryGamesBloc>().games,
                                                          scaffoldKey: scaffoldKey
                                                      ),
                                                      SizedBox(height: 30,)
                                                    ],
                                                  );
                                          }
                                        }),
                                  );
                                },
                                childCount: 1,
                              ))
                        ]),
                  ),
                  floatingActionButton: context.watch<CategoryGamesBloc>().isScroll == true
                      && context.watch<CategoryGamesBloc>().games.isNotEmpty
                      ? ScrollToTop(controller: _controller) : Text('')
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: LoadMore(
                    loading: context.watch<CategoryGamesBloc>().loading),
              ),
            ],

          ),
        );
      } else {
        return NoInternet();
      }
    });
  }


  Future _onRefresh() async {
    var cr = await ( Connectivity().checkConnectivity());
    if (cr == ConnectivityResult.wifi || cr == ConnectivityResult.mobile) {
      context.read<CategoryGamesBloc>().setScroll(false);
      context.read<CategoryGamesBloc>().onReload();
    } else {
      openSnacbar(scaffoldKey, st.networkIssue,
          CupertinoIcons.wifi_slash);
    }
  }
}