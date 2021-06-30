

import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/widgets/last_games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);
  _HomeState  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    print("----- Init State");
    Future.delayed(Duration(seconds: 1)).then((value) => context.read<NewGamesBloc>().getGames());
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
            child: SingleChildScrollView(  // ++++++++++++++++++++
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    title: Text("CN"),
                  ),

                   LastGames(
                       gamz: context.watch<NewGamesBloc>().games, scaffoldKey: scaffoldKey
                   ),
                ],
              ),
            )

        ),

      ),

    );






  } //// build End
}

