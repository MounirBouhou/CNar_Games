import 'dart:convert';
import 'package:cnargames/config/wp_config.dart';
import 'package:cnargames/models/games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryGamesBloc extends ChangeNotifier {

  int _postAmount = 12;
  int _t = 1126;

  String? _catid;

  int _page = 1;
  int get page => _page;

  List<Games> _games = [];
  List<Games> get games => _games;

  bool _loading = false;
  bool get loading => _loading;

  bool _isScroll= false;
  bool get isScroll => _isScroll;

  bool _empty = false;
  bool get empty => _empty;

  // Future getTag() async{
  //   _games.clear();
  //   _page = 1;
  //   notifyListeners();
  //   var response = await http.get(Uri.parse("${WpConfig().webURL}/wp-json/myplugin/v1/taggames"));
  //   if (response.statusCode == 200){
  //     var decodedData = jsonDecode(response.body);
  //     t = decodedData[0];
  //     print('Tag id ====  $t ');
  //   } else {
  //     print("error tag");
  //   }
  // }

  Future getCatGames() async {
    //_games.clear();
    var response = await http.get(Uri.parse(
        "${WpConfig().webURL}/wp-json/wp/v2/posts?categories[]=" + _catid! + "&page=$page&tags=1126&per_page=$_postAmount&_fields=id,date,title,content,custom,link"));
    if (response.statusCode == 200) {
      List decodedData = jsonDecode(response.body);
      _games.addAll(decodedData.map((m) => Games.fromJson(m)).toList());
      int gl = _games.length;
      print('Total Cat Games: $gl ');
    } else {
      print("Error Getting Cat Games!");
    }
    notifyListeners();
  }

  clearGames() {
    _games.clear();
    _page = 1;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  catID(String value) {
    _catid = value;
    //notifyListeners();
  }

  setScroll(bool value) {
    _isScroll = value;
    notifyListeners();
  }

  pageIncrement() {
    _page += 1;
    notifyListeners();
  }

  onReload() async {
    _games.clear();
    _page = 1;
    notifyListeners();
    getCatGames();
    print("onReload Cat Games");
  }
}
