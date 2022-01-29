import 'dart:async';

import 'package:cnargames/blocs/ad_bloc.dart';
import 'package:cnargames/blocs/category_bloc.dart';
import 'package:cnargames/blocs/featured_games_bloc.dart';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/ad_config.dart';
import 'package:cnargames/config/config.dart';
import 'package:cnargames/config/strings.dart';
import 'package:cnargames/services/connectivity_provider.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:cnargames/utils/scroll_to_top.dart';
import 'package:cnargames/utils/snacbar.dart';
import 'package:cnargames/widgets/drawer.dart';
import 'package:cnargames/widgets/last_games.dart';
import 'package:cnargames/widgets/last_games_categories.dart';
import 'package:cnargames/widgets/load_more.dart';
import 'package:cnargames/widgets/no_internet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'bookmark.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController? _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future? getGg;
  Future? getCc;


  @override
  void initState() {
    super.initState();
    print('---!! init');



    // Start Monitoring
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    // Scroller
    _controller =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    _controller!.addListener((_scrollListener));

    //getGamesCategories = context.read<NewGamesBloc>().getGames().then((value) => context.read<CategoryBloc>().getCat());
    getGg = context.read<NewGamesBloc>().getGames().then((value) => context.read<FeaturedGamesBloc>().getFeaturedGames());
    getCc = context.read<CategoryBloc>().getCat();

    // -- Admob Ad Enable/Disable --
    AdConfig().initAdmob().then((value) => context.read<AdsBloc>().initiateAds());
  }

  _scrollListener() async {
    var isEnd = _controller!.offset >= _controller!.position.maxScrollExtent &&
        !_controller!.position.outOfRange;
    if (context.read<NewGamesBloc>().games.isNotEmpty && isEnd) {

      context.read<NewGamesBloc>().pageIncrement();
      context.read<NewGamesBloc>().setLoading(true);
      context.read<NewGamesBloc>().setScroll(true);
      await context.read<NewGamesBloc>().getGames().then((value) {
        context.read<NewGamesBloc>().setLoading(false);
      });
    } else {
      //context.read<NewGamesBloc>().setScroll(false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (c, connectivityProvider, child) {
      if (connectivityProvider.isOnline) {
        return AnnotatedRegion(
            value: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: Stack(
          children:[

       // LoadMore(loading: context.watch<NewGamesBloc>().loading),


            Scaffold(
            key: scaffoldKey,
            endDrawer: CustomDrawer(),
            body:RefreshIndicator(
              onRefresh: () async => await _onRefresh(),
              child: CustomScrollView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                controller:  _controller,
                slivers: <Widget>[

                  SliverAppBar(
                    // bottom: PreferredSize(
                    //   child: Directionality(
                    //     textDirection: TextDirection.rtl,
                    //     child: Container(
                    //       color: cColors().gray,
                    //       child: FutureBuilder(
                    //           future: getCc,
                    //           builder: (BuildContext c,
                    //               AsyncSnapshot<dynamic> snapshot) {
                    //             switch (snapshot.connectionState) {
                    //
                    //               default:
                    //                 if (snapshot.hasError)
                    //                   return Text('snapshot.hasError');
                    //                 else
                    //                   return LastCategories(
                    //                       catz: context.watch<CategoryBloc>().cat,
                    //                       scaffoldKey: scaffoldKey);
                    //             }
                    //           }),
                    //     ),
                    //   ),
                    //
                    //   //: Container(),
                    //   //preferredSize:Size.fromHeight(isOpen? 100:0)
                    //   preferredSize: Size(90, 94),
                    // ),
                    //backgroundColor: cColors().bg,

                      title: Text(st.home),
                      leading: Center(
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Image(
                              height: 100,
                              width: 100,
                              fit: BoxFit.contain,
                              image: AssetImage(Config().splash),
                            )
                        ),
                      ),
                      actions: <Widget>[
                        IconButton(
                          onPressed: () =>
                              nextScreen(context, Bookmark()),
                          icon: Padding(
                              padding: EdgeInsets.only(left: 20),child: Icon(Icons.favorite_outline_sharp,)),
                        ),
                        IconButton(
                          onPressed: () =>
                              scaffoldKey.currentState!.openEndDrawer(),
                          icon: Icon(Icons.menu,),
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
                                            return LastCategories(
                                                catz: context.watch<CategoryBloc>().cat,
                                                scaffoldKey: scaffoldKey);
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      return Directionality(
                          textDirection: TextDirection.rtl,
                          child: RefreshIndicator(
                              onRefresh: () async => await _onRefresh(),
                              child: new FutureBuilder(
                                  future: getGg,
                                  builder: (BuildContext c, AsyncSnapshot<dynamic> snapshot) {
                                    switch (snapshot.connectionState) {

                                      default:
                                        if (snapshot.hasError)


                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Container(
                                              padding: EdgeInsets.all(0),
                                              alignment: Alignment.topCenter,
                                              //height: MediaQuery.of(context).size.height / 2,
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    Config().netOn,
                                                    fit: BoxFit.fill,
                                                    // alignment: Alignment.topCenter,
                                                    height: 200,
                                                    width: 200,
                                                  ),

                                                  SizedBox(
                                                    height: 20,
                                                  ),

                                                  CupertinoButton(
                                                    // pressedOpacity: 0.4,
                                                    color: cColors().blueDark,
                                                    child: Text(st.letsPlay, style: TextStyle(
                                                        color: cColors().gray,
                                                        fontSize: 22, fontFamily: 'Cairo', fontWeight: FontWeight.w700
                                                    ),),
                                                    onPressed: (){
                                                      getGg = context.read<NewGamesBloc>().getGames().then((value) => context.read<FeaturedGamesBloc>().getFeaturedGames());
                                                      getCc = context.read<CategoryBloc>().getCat();
                                                    },
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );

                                        else
                                          return
                                            Column(
                                              children: [
                                                LastGames(
                                                    fgames: context.watch<FeaturedGamesBloc>().fgames,
                                                    gamz: context.watch<NewGamesBloc>().games,
                                                    scaffoldKey: scaffoldKey
                                                ),

                                                SizedBox(height: 30,)
                                              ],

                                            );
                                    }
                                  })
                          )
                      );


                    },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ),
            //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: context.watch<NewGamesBloc>().isScroll == true ? ScrollToTop(controller: _controller) : Text('')
        ),


            Align(
              alignment: Alignment.bottomRight,
              child: LoadMore(
                  loading: context.watch<NewGamesBloc>().loading),
            ),
          ]

        )
        );

       // );
      } else {
        return NoInternet();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future _onRefresh() async {
    var cr = await ( Connectivity().checkConnectivity());
    if (cr == ConnectivityResult.wifi || cr == ConnectivityResult.mobile) {
      context.read<NewGamesBloc>().setScroll(false);
      context.read<CategoryBloc>().onReload();
      context.read<NewGamesBloc>().onReload();
    } else {
      openSnacbar(scaffoldKey, st.networkIssue,
          CupertinoIcons.wifi_slash);
    }
  }
} // end
