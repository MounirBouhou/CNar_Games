import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class CustomCacheImage extends StatelessWidget{
  final String? img;
  final double? h;
  final double? w;

  const CustomCacheImage({
    required this.img,
    required this.h,
    required this.w
  });

  //final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CachedNetworkImage(
        imageUrl: img!,
        fit: BoxFit.fill,
        height: h,
        width: w,
      )
    );


  }




}