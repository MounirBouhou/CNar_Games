import 'dart:async';
import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/services/app_services.dart';
import 'package:cnargames/services/connectivity_provider.dart';
import 'package:cnargames/utils/snacbar.dart';
import 'package:cnargames/widgets/drawer.dart';
import 'package:cnargames/widgets/last_games.dart';
import 'package:cnargames/widgets/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController? _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>() ;
  Future? getGames;

  @override
  void initState() {
    super.initState();
    // Start Monitoring
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    // Scroller
    _controller = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    _controller!.addListener((_scrollListener));
    // getGames
    getGames =  context.read<NewGamesBloc>().getGames();
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
      });
    } else {}
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (c, model, child) {
          if (model.isOnline) {
            return new Scaffold(
                key: scaffoldKey,
                backgroundColor: cColors().blueDark,
                endDrawer: CustomDrawer(),
                appBar: AppBar(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                new FutureBuilder(
                                  future:  getGames,
                                  builder: (BuildContext c, AsyncSnapshot<dynamic> snapshot) {
                                    switch (snapshot.connectionState) {

                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
                                        return Center(
                                          child: Container(
                                            width: double.infinity,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height,
                                            alignment: Alignment.center,
                                            child: CircularProgressIndicator(strokeWidth: 2),
                                          ),
                                        );

                                      default:
                                        if (snapshot.hasError)
                                          return Container(
                                            color: cColors().blueDark,
                                            height: MediaQuery.of(context).size.height,
                                            child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // Max Size
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Text("جهازك الآن متصل بالشبكة", style: TextStyle(
                                                      color: cColors().gray,
                                                      fontSize: 25, fontWeight: FontWeight.w700
                                                  ),),
                                                ),

                                                CupertinoButton(
                                                  pressedOpacity: 0.4,
                                                  color: cColors().yellowDark,
                                                  child: Text('هيا نلعب', style: TextStyle(
                                                      color: cColors().blueDark,
                                                    fontSize: 25, fontFamily: 'Cairo', fontWeight: FontWeight.w700
                                                ),),
                                                  onPressed: (){
                                                    context.read<NewGamesBloc>().clearGames();
                                                    getGames = context.read<NewGamesBloc>().getGames();
                                                  },
                                                ),

                                                Positioned.fill(
                                                  child: Image.asset(
                                                    "assets/images/okNet.png",
                                                    fit: BoxFit.fitWidth,
                                                    alignment: Alignment.bottomRight,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        else
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: LastGames(
                                               gamz: context.watch<NewGamesBloc>().games,
                                               scaffoldKey: scaffoldKey),
                                          );
                                    }
                                  }
                                ),
                                loadMoreGamesWidget(),
                              ],
                            ),
                          )),

                    )));

          } else {
            return NoInternet();
          }
        }
    );
  }

  Future _onRefresh() async {
    ConnectivityProvider().updateConnectionStatus().then((hasInternet) {
      if (hasInternet!){
        context.read<NewGamesBloc>().onReload();
      } else {
        openSnacbar(scaffoldKey, "لا يوجد اتصال بالشبكة!", cColors().pinkDark, CupertinoIcons.wifi_slash);
      }
    });
  }


  Widget loadMoreGamesWidget(){
    return Opacity(
      opacity: context.watch<NewGamesBloc>().loading == true
          ? 1.0
          : 0.0,
      child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(strokeWidth: 2),
              SizedBox(
                width: 10,
              ),
              Text('جار تحميل المزيد...')
            ],
          )),
    );
  }

} // end
