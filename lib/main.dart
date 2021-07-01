import 'package:cnargames/blocs/new_games_bloc.dart';
import 'package:cnargames/pages/home.dart';
import 'package:cnargames/services/app_services.dart';
import 'package:cnargames/utils/snacbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  print('Main is running');
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewGamesBloc()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: new Home(),
        ),
      )

  ));
}





