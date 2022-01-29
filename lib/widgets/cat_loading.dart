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
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                    opacity: 0.4,
                    child: CustomCacheImage(img: catThumb, w: 120, h: 120)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            st.loading,
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
