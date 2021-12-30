import 'package:cnargames/config/wp_config.dart';
import 'package:jiffy/jiffy.dart';


class Games {
  final int? id;
  final String? title;
  final String? content;
  final String? image;
  final String? game;
  final String? width;
  final String? height;
  final String? views;
  final String? rate;
  final String? category;
  final String? date;
  final int? catId;

  Games({this.id, this.title, this.content, this.image, this.game, this.width, this.height, this.views, this.rate, this.category, this.date, this.catId});

  factory Games.fromJson(Map<String, dynamic> json){
    return Games(
        id:json['id'] ?? 0,
        title:json['title']['rendered'] ?? '',
        content:json['content']['rendered'] != "" ? json['content']['rendered'] : "لعبة " + json['title']['rendered'],
        image:json['custom']['featured_image'] != "" ? json['custom']['featured_image'] : WpConfig().randomGameFeaturedImage,
        game:json['custom']['mabp_swf_url'] ?? '',
        width:json['custom']['mabp_width'] ?? '',
        height:json['custom']['mabp_height'] ?? '',
        views:json['custom']['views'] ?? '',
        rate:json['custom']['ratings_average'] ?? '',
        category:json['custom']['categories'][0]['name'] ?? '',
        date: Jiffy(json['date']).fromNow(),
        catId:json['custom']['categories'][0]['cat_ID'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title']['rendered'] = this.title;
    data['content']['rendered'] = this.content;
    data['custom']['featured_image'] = this.image;
    data['custom']['mabp_swf_url'] = this.game;
    data['custom']['mabp_width'] = this.width;
    data['custom']['mabp_height'] = this.height;
    data['custom']['views']  = this.views;
    data['custom']['ratings_average'] = this.rate;
    data['custom']['categories'][0]['name'] = this.category;
    data['custom']['categories'][0]['cat_ID'] = this.catId;
    data['date'] = this.date;

    return data;
  }


}