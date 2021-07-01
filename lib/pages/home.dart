

import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/services/app_services.dart';
import 'package:cnargames/utils/snacbar.dart';
import 'package:cnargames/widgets/last_games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);
  _HomeState  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController? _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    // Scroller
    _controller = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
   // _controller!.addListener(_scrollListner)
    // Call the Games
    AppServices().checkInternet().then(
        (hasInternet){
          if (hasInternet!){
            Future.delayed(Duration(seconds: 0)).then((value) => context.read<NewGamesBloc>().getGames());
          } else {
            openSnacbar(scaffoldKey, "مشكلة في الانترنت!");
          }
        });
  }

  Future _onRefresh() async {
    print("----- _onRefresh");
    context.read<NewGamesBloc>().getGames();
  }


  @override
  Widget build(BuildContext context) {
   // super.build(context);
    return Scaffold(
      key: scaffoldKey,

      body: SafeArea(
        child: RefreshIndicator(onRefresh: () async => await _onRefresh(),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              controller: _controller,// ++++++++++++++++++++
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    title: Text("CN"),
                  ),

                  LastGames( gamz: context.watch<NewGamesBloc>().games, scaffoldKey: scaffoldKey ),

                  // Opacity(
                  //   opacity: context.watch<NewGamesBloc>().loading == true ? 1.0 : 0.0,
                  //   child: Container(
                  //       height: 60,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           CupertinoActivityIndicator(),
                  //           SizedBox(width: 10,),
                  //           Text('Loading contents')
                  //         ],
                  //       )
                  //   ),
                  // )


                ],
              ),
            )
        ),
      ),
    );
  } //// build End
}

