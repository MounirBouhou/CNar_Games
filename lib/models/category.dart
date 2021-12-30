
import 'package:cnargames/config/wp_config.dart';

class mCategory{

  final int? id;
  final String? name;
  final String? thumb;

  mCategory({ this.id, this.name, this.thumb });

  factory mCategory.fromJson(Map<String, dynamic> json){
    return mCategory(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        thumb: json['thumb'] ?? WpConfig().randomGameFeaturedImage,
    );
  }

}