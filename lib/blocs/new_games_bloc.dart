

import 'dart:convert';
import 'package:cnargames/config/wp_config.dart';
import 'package:cnargames/models/games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewGamesBloc extends ChangeNotifier{

  int _postAmountPerLoad = 10;

  int _page = 1;
  int get page => _page;

  List<Games> _games = [];
  List<Games> get games => _games;

  bool _loading = false;
  bool get loading => _loading;

  Future getGames() async {
    var response = await http.get(Uri.parse("${WpConfig().webURL}/wp-json/wp/v2/posts/?page=$_page&per_page=$_postAmountPerLoad&tags=1126&_embed=true&_fields=id,date,title,content,custom,link"));
    if (response.statusCode == 200){
      List decodedData = jsonDecode(response.body);
      _games.addAll(decodedData.map((m) => Games.fromJson(m)).toList());
      int gl = _games.length;
      print('Total Games: $gl ');
    } else {
      print("Error Getting Games!");
    }
   notifyListeners();
  }

  clearGames(){
    _games.clear();
    _page = 1;
    notifyListeners();
  }

  setLoading (bool value){
    _loading = value;
    notifyListeners();
  }

  pageIncrement(){
    _page += 1;
    notifyListeners();
  }

  onReload() async{
    _games.clear();
    _page = 1;
    notifyListeners();
    getGames();
    print("onReload");
  }


}