import 'package:cnargames/blocs/category_bloc.dart';
import 'package:cnargames/pages/Splash.dart';
import 'package:cnargames/services/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/ad_bloc.dart';
import 'blocs/category_games.dart';
import 'blocs/featured_games_bloc.dart';
import 'blocs/new_games_bloc.dart';
import 'blocs/theme_bloc.dart';
import 'models/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),

      // The Consumer widget doesn't do any fancy work. It just calls Provider.
      // of in a new widget, and delegates its build implementation to builder.
      child: Consumer<ThemeBloc>(
        builder: (_, mode, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<CategoryBloc>(
                    create: (context) => CategoryBloc()),
                ChangeNotifierProvider<NewGamesBloc>(
                    create: (context) => NewGamesBloc()),
                ChangeNotifierProvider<CategoryGamesBloc>(
                    create: (context) => CategoryGamesBloc()),
                ChangeNotifierProvider<FeaturedGamesBloc>(
                    create: (context) => FeaturedGamesBloc()),
                ChangeNotifierProvider<ConnectivityProvider>(
                    create: (_) => ConnectivityProvider()),
                ChangeNotifierProvider<AdsBloc>(create: (context) => AdsBloc()),
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeModel().lightTheme,
                  darkTheme: ThemeModel().darkTheme,
                  themeMode:
                      mode.darkTheme == true ? ThemeMode.dark : ThemeMode.light,

                  home: SplashPage()));
        },
      ),
    );
  }
}
