import 'dart:async';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/services/app_services.dart';
import 'package:cnargames/services/connectivity_provider.dart';
import 'package:cnargames/utils/snacbar.dart';
import 'package:cnargames/widgets/drawer.dart';
import 'package:cnargames/widgets/last_games.dart';
import 'package:cnargames/widgets/loading.dart';
import 'package:cnargames/widgets/no_internet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController? _controller;
  bool _showBackToTopButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    // Start Monitoring
    //Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    // Scroller
    _controller = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    _controller!.addListener((_scrollListener));

    // _controller!.addListener(() {
    //       setState(() {
    //         if (_controller!.offset >= 400 ){
    //           _showBackToTopButton = true;
    //         } else {
    //           _showBackToTopButton = false;
    //         }
    //       });
    //     }
    // );

    Future.delayed(Duration(milliseconds: 1)).then((value) => _onStart());
    // next feature AdMob
    //AdConfig().initAdmob().then((value) => context.read<AdsBloc>().initiateAds());
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: cColors().blueDark,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: IconButton(
                onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
                icon: Icon(
                  Icons.menu,
                  color: cColors().gray,
                  size: 30.0,
                ),
              )),
        ],
      ),

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => await _onRefresh(),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  LastGames(
                      gamz: context.read<NewGamesBloc>().games,
                      scaffoldKey: scaffoldKey
                  ),

                  loadMoreGamesWidget(),

                ],
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
        onPressed: _scrollToTop,
        child: Icon(Icons.arrow_upward),
        mini: true,
      ),

    );
  }


  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _controller!.animateTo(1, duration: Duration(seconds: 2), curve: Curves.linearToEaseOut);
  }

  // @override
  // Widget build(BuildContext context) {
  //   // return Consumer<ConnectivityProvider>(
  //   //     builder: (c, model, child) {
  //   //       if (model.isOnline) {
  //           return new Scaffold(
  //               key: scaffoldKey,
  //               backgroundColor: cColors().blueDark,
  //               endDrawer: CustomDrawer(),
  //               appBar: AppBar(
  //                 actions: <Widget>[
  //                   Padding(
  //                       padding: EdgeInsets.only(right: 25.0),
  //                       child: IconButton(
  //                         onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
  //                         icon: Icon(
  //                           Icons.menu,
  //                           color: cColors().gray,
  //                           size: 30.0,
  //                         ),
  //                       )),
  //                 ],
  //                 //title: Text("CN"),
  //                 elevation: 0,
  //               ),
  //
  //               body: Directionality(
  //                   textDirection: TextDirection.rtl,
  //                   child: SafeArea(
  //                     child: RefreshIndicator(
  //                         onRefresh: () async => await _onRefresh(),
  //                         child: SingleChildScrollView(
  //                           physics: ClampingScrollPhysics(),
  //                           controller: _controller, // +++
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               FutureBuilder(
  //                                   future:  getGames,
  //                                   builder: (BuildContext c, AsyncSnapshot<dynamic> snapshot) {
  //                                     switch (snapshot.connectionState) {
  //
  //                                       case ConnectionState.none:
  //                                         return Center(
  //                                           child: Text("ConnectionNone"),
  //                                         );
  //
  //                                       case ConnectionState.waiting:
  //                                         return Center(
  //                                           child: loading(context)
  //                                         );
  //
  //                                       default:
  //                                         if (snapshot.hasError)
  //                                           return new FutureBuilder(
  //                                             future: getGames = context.read<NewGamesBloc>().getGames() ,
  //                                             builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //                                               return Padding(
  //                                                 padding: const EdgeInsets.all(8.0),
  //                                                 child: Column(
  //                                                   children: [
  //                                                     LastGames(
  //                                                         gamz: context.watch<NewGamesBloc>().games,
  //                                                         scaffoldKey: scaffoldKey),
  //                                                     loadMoreGamesWidget(),
  //                                                   ],
  //                                                 ),
  //                                               );
  //                                             },
  //                                           );
  //                                         else
  //                                           return Padding(
  //                                             padding: const EdgeInsets.all(8.0),
  //                                             child: Column(
  //                                               children: [
  //                                                 LastGames(
  //                                                     gamz: context.watch<NewGamesBloc>().games,
  //                                                     scaffoldKey: scaffoldKey),
  //                                                 loadMoreGamesWidget(),
  //                                               ],
  //                                             ),
  //                                           );
  //                                     }
  //                                   }
  //                               ),
  //                             ],
  //                           ),
  //                         )),
  //
  //                   ))
  //           );
  //         // } else {
  //         //   return NoInternet();
  //         // }
  //       }
  //   //);
  // //}

  Future _onStart() async {
    var cr = await (Connectivity().checkConnectivity());
    if (cr == ConnectivityResult.wifi || cr == ConnectivityResult.mobile) {
      context.read<NewGamesBloc>().getGames();
    } else {
      openSnacbar(scaffoldKey, "لا يوجد اتصال بالشبكة!", cColors().pinkDark,
          CupertinoIcons.wifi_slash);
     // return NoInternet();
    }
  }

  Future _onRefresh() async {
    var cr = await (Connectivity().checkConnectivity());
    // ConnectivityProvider().updateConnectionStatus().then((hasInternet) {
    //   if (hasInternet!){
    if (cr == ConnectivityResult.wifi || cr == ConnectivityResult.mobile) {
      context.read<NewGamesBloc>().onReload();
    } else {
      openSnacbar(scaffoldKey, "لا يوجد اتصال بالشبكة!", cColors().pinkDark,
          CupertinoIcons.wifi_slash);
    }
  }

  Widget loadMoreGamesWidget() {
    return Opacity(
      opacity: context.watch<NewGamesBloc>().loading == true ? 1.0 : 0.0,
      child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: cColors().gray, backgroundColor: cColors().pinkDark, strokeWidth: 2),
              SizedBox(
                width: 10,
              ),
              Text('جار تحميل المزيد...', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: cColors().gray
              ),),
            ],
          )),
    );
  }
} // end
