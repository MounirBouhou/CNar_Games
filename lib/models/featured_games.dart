import 'package:cnargames/config/wp_config.dart';
import 'package:jiffy/jiffy.dart';


class FeaturedGames {
  final int? id;
  final String? title;
  final String? content;
  final String? imageFeatured;
  final String? game;
  final String? width;
  final String? height;
  final String? views;
  final String? rate;
  final String? category;
  final String? date;
  final int? catId;

  FeaturedGames({this.id, this.title, this.content, this.imageFeatured, this.game, this.width, this.height, this.views, this.rate, this.category, this.date, this.catId});

  factory FeaturedGames.fromJson(Map<String, dynamic> json){
    return FeaturedGames(
        id:json['id'] ?? 0,
        title:json['title']['rendered'] ?? '',
        content:json['content']['rendered'] != "" ? json['content']['rendered'] : "إلعب معنا لعبة " + json['title']['rendered'] + " واحدة من افضل العاب " + json['custom']['categories'][0]['name'] + " الرائعة و المسلية، عالم العاب الكرتون عالم مليء بالمفاجآت فهناك العاب اخرى جد ممتعة على تطبيقنا ",
        imageFeatured:json['custom']['mabp_screen1_url'] != "" ? json['custom']['mabp_screen1_url'] : WpConfig().randomGameFeaturedImage,
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
    data['custom']['mabp_screen1_url'] = this.imageFeatured;
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