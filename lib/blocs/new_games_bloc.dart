

import 'dart:convert';

import 'package:cnargames/config/wp_config.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/utils/snacbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewGamesBloc extends ChangeNotifier{
  int _page = 1;
  int _postAmountPerLoad = 10;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Games> _games = [];
  List<Games> get games => _games;

  Future getGames() async {
    var response = await http.get(Uri.parse("${WpConfig().webURL}/wp-json/wp/v2/posts/?page=$_page&per_page=$_postAmountPerLoad&_fields=id,date,title,content,custom,link"));
    if (response.statusCode == 200){
      List decodedData = jsonDecode(response.body);
      _games.addAll(decodedData.map((m) => Games.fromJson(m)).toList());
      var a =  _games.length;
      print("Data Received! $a");
      print("Data ----- -- +++ === $decodedData");
    } else {
      print("Error Getting Data!");
    }
   notifyListeners();
  }


}