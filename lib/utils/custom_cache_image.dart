import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCacheImage extends StatelessWidget{
  final String? img;
  const CustomCacheImage({
    required this.img
  });

  //final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CachedNetworkImage(
        imageUrl: img!,
        fit: BoxFit.cover,
        height: 200,
      )
    );


  }




}