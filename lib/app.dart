

import 'package:cnargames/pages/Splash.dart';
import 'package:cnargames/services/connectivity_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';

class MyApp extends StatelessWidget{
  @override

  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
              ChangeNotifierProvider<NewGamesBloc>(create: (context) => NewGamesBloc()),
              ChangeNotifierProvider<ConnectivityProvider>(create: (_) => ConnectivityProvider()),
              //ChangeNotifierProvider<AdsBloc>(create: (_) => AdsBloc()),
      ],

      child: MaterialApp(
           debugShowCheckedModeBanner: false,
           theme: ThemeData(
             fontFamily: 'Cairo',
             primaryColor: cColors().blueDark,
             accentColor: cColors().pinkDark,
           ),

           home: SplashPage(),
      ),
         );
        }

}