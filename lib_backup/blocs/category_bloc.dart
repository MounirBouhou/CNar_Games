import 'dart:convert';
import 'package:cnargames/config/wp_config.dart';
import 'package:cnargames/models/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoryBloc extends ChangeNotifier{

  List<mCategory> _cat = [];
  List<mCategory> get cat => _cat;

  Future getCat() async {
    _cat.clear();
    var response = await http.get(Uri.parse("${WpConfig().webURL}/wp-json/wp/v2/categories?page=1&per_page=30&orderby=count&order=desc&exclude=1,1134,1135,1136,1137,1138," +
        "1139,1140,1141,1142,1143,1144,1145,1146,1147,1148,1149,1150,1151,1152,100,101,106,119,85,109,428,1108,683," +
        "86,870,110,684,66,1128,1132,116,826,365,118,108,99,53,112,21,54,484,426,103,107,117,1131,427,115,425,366," +
        "1133,67,105,102,14,22,34,367"));
    if (response.statusCode == 200){
       List decodedData = jsonDecode(response.body);
       _cat.addAll(decodedData.map((m) => mCategory.fromJson(m)).toList());
    } else {
      print("Error Getting Category!");
    }
    notifyListeners();
  }

  clearGames() {
    _cat.clear();
    notifyListeners();
  }

  onReload() async{
    _cat.clear();
    notifyListeners();
    getCat();
    print("onReload");
  }

}