import 'dart:async';
import 'dart:io';

import 'package:cnargames/blocs/ad_bloc.dart';
import 'package:cnargames/blocs/category_bloc.dart';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/ad_config.dart';
import 'package:cnargames/config/config.dart';
import 'package:cnargames/services/connectivity_provider.dart';
import 'package:cnargames/utils/scroll_to_top.dart';
import 'package:cnargames/utils/snacbar.dart';
import 'package:cnargames/widgets/drawer.dart';
import 'package:cnargames/widgets/last_games_categories.dart';
import 'package:cnargames/widgets/load_more.dart';
import 'package:cnargames/widgets/no_internet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController? _controller;
  bool _showBackToTopButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future? getGamesCategories;



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

    getGamesCategories = context.read<NewGamesBloc>().getGames().then((value) => context.read<CategoryBloc>().getCat());

    // -- Admob Ad Enable/Disable --
    AdConfig().initAdmob().then((value) => context.read<AdsBloc>().initiateAds());

  }

  _scrollListener() async {
    var isEnd = _controller!.offset >= _controller!.position.maxScrollExtent &&
        !_controller!.position.outOfRange;
    if (context.read<NewGamesBloc>().games.isNotEmpty && isEnd) {
      context.read<NewGamesBloc>().pageIncrement();
      context.read<NewGamesBloc>().setLoading(true);
      await context.read<NewGamesBloc>().getGames().then((value) {
        context.read<NewGamesBloc>().setLoading(false);
        _showBackToTopButton = true;
      });
    } else {
      _showBackToTopButton = false;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<ConnectivityProvider>(builder: (c, model, child) {
        if (model.isOnline) {
          return Scaffold(
              key: scaffoldKey,
              backgroundColor: cColors().bg,
              endDrawer: CustomDrawer(),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
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

                leadingWidth: 80,

                centerTitle: true,
                title: Text( 'الرئيسية',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: cColors().pinkDark),
                ),

                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 25.0),
                      child: IconButton(
                        onPressed: () =>
                            scaffoldKey.currentState!.openEndDrawer(),
                        icon: Icon(
                          Icons.menu,
                          color: cColors().pinkDark,
                          size: 30.0,
                        ),
                      )),
                ],
                //title: Text("CN"),
                elevation: 0,
              ),

              body: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SafeArea(
                    child: RefreshIndicator(
                       onRefresh: () async => await _onRefresh(),
                       child: SingleChildScrollView(
                         physics: ClampingScrollPhysics(),
                         controller: _controller, // +++
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             new FutureBuilder(
                                 future: getGamesCategories,
                                 builder: (BuildContext c,
                                     AsyncSnapshot<dynamic> snapshot) {
                                   switch (snapshot.connectionState) {

                                     default:
                                       if (snapshot.hasError)
                                         return retryGames();
                                       else
                                         return LastGamesCategories(
                                             catz: context.watch<CategoryBloc>().cat,
                                             gamz: context.watch<NewGamesBloc>().games,
                                             scaffoldKey: scaffoldKey);
                                   }
                                 }),
                             LoadMore(
                               loading: context.watch<NewGamesBloc>().loading, color: cColors().darkGray,),

                           ],
                         ),
                       )
                        ),
                  )
              ),
              floatingActionButton: _showBackToTopButton == false
                  ? null
                  : ScrollToTop(controller: _controller));
        } else {
          return NoInternet();
        }
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Widget retryGames() {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text("جهازك الآن متصل بالشبكة", style: TextStyle(
                  color: cColors().pinkDark,
                  fontSize: 25, fontWeight: FontWeight.w700
              ),),
            ),

            CupertinoButton(
              pressedOpacity: 0.4,
              color: cColors().gray,
              child: Text('هيا نلعب !', style: TextStyle(
                  color: cColors().pinkDark,
                  fontSize: 25, fontFamily: 'Cairo', fontWeight: FontWeight.w700
              ),),
              onPressed: (){
                getGamesCategories =
                    context.read<CategoryBloc>().getCat();
                    context.read<NewGamesBloc>().getGames();
              },
            ),

            Opacity(
              opacity: 0.8,
              child: Positioned.fill(
                child: Image.asset(
                  "assets/images/okNet.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomRight,
                ),
              ),
            )


          ],
        ),
      ),

    );

  }

  Future _onRefresh() async {
    var cr = await ( Connectivity().checkConnectivity());
    if (cr == ConnectivityResult.wifi || cr == ConnectivityResult.mobile) {
        context.read<CategoryBloc>().onReload();
        context.read<NewGamesBloc>().onReload();
    } else {
      openSnacbar(scaffoldKey, "لا يوجد اتصال بالشبكة!", cColors().pinkDark,
          CupertinoIcons.wifi_slash);
    }
  }
} // end
