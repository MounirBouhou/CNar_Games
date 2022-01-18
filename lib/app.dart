

import 'package:cnargames/blocs/category_bloc.dart';
import 'package:cnargames/pages/Splash.dart';
import 'package:cnargames/services/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/ad_bloc.dart';
import 'blocs/new_games_bloc.dart';
import 'package:cnargames/colors/custom_colors.dart';

class MyApp extends StatelessWidget{
  @override

  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
              ChangeNotifierProvider<CategoryBloc>(create: (context) => CategoryBloc()),
              ChangeNotifierProvider<NewGamesBloc>(create: (context) => NewGamesBloc()),
              ChangeNotifierProvider<ConnectivityProvider>(create: (_) => ConnectivityProvider()),
              ChangeNotifierProvider<AdsBloc>(create: (context) => AdsBloc()),
      ],

      child: MaterialApp(
           debugShowCheckedModeBanner: false,
           theme: ThemeData(
             fontFamily: 'Cairo',
             primaryColor: cColors().blueDark, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: cColors().pinkDark),
           ),
           home: SplashPage(),
      ),
         );
        }

}