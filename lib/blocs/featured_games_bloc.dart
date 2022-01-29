import 'dart:convert';
import 'package:cnargames/config/wp_config.dart';
import 'package:cnargames/models/featured_games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeaturedGamesBloc extends ChangeNotifier {
  int _postAmountPerLoad = 5;
  //int _tag = 1126; // get only the HTML5 mobile games tag
  //int _tag = 1172; // get only the HTML5 mobile games tag

  int _t = 1178;

  int _page = 1;
  int get page => _page;

  List<FeaturedGames> _fgames = [];
  List<FeaturedGames> get fgames => _fgames;

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

  Future getFeaturedGames() async {
    var response = await http.get(Uri.parse(
        "${WpConfig().webURL}/wp-json/wp/v2/posts/?page=$_page&per_page=$_postAmountPerLoad&tags=$_t&_embed=true&_fields=id,date,title,content,custom,link"));
    if (response.statusCode == 200) {
      List decodedData = jsonDecode(response.body);
      _fgames
          .addAll(decodedData.map((m) => FeaturedGames.fromJson(m)).toList());
      int gl = _fgames.length;
      print('Total Featured Games: $gl ');
    } else {
      print("Error Getting Featured Games!");
    }
    notifyListeners();
  }

  clearGames() {
    _fgames.clear();
    _page = 1;
    notifyListeners();
  }

  onReload() async {
    _fgames.clear();
    _page = 1;
    notifyListeners();
    getFeaturedGames();
    print("onReload");
  }
}
