import 'package:cnargames/config/wp_config.dart';
import 'package:jiffy/jiffy.dart';


class Tags {

  final String? tags;

  Tags({this.tags});

  factory Tags.fromJson(Map<String, dynamic> json){
    return Tags( tags:json['tag']['id'] ?? '' );
  }

}