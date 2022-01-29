import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/strings.dart';
import 'package:cnargames/utils/custom_cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatLoading extends StatelessWidget {
  final String? catThumb;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CatLoading({Key? key, required this.catThumb, required this.scaffoldKey})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 210,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(opacity: 0.4,
          child: CustomCacheImage(img: catThumb, w:120, h:120)),
          // SizedBox(height: 40,),
          // CircularProgressIndicator(color: cColors().pinkDark, backgroundColor: cColors().gray, strokeWidth: 2),
          SizedBox(height: 8),
          Text(st.loading,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).iconTheme.color
            ),),
        ],
      ),
    );
  }
}
