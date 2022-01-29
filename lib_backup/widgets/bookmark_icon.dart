import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/services/bookmark_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({
    Key? key,
    required this.bookmarkedList,
    required this.games,
    required this.scaffoldKey,
    required this.iconSize,
    this.iconColor,
    this.normalIconColor
  }) : super(key: key);

  final Box bookmarkedList;
  final Games? games;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double iconSize;
  final Color? iconColor;
  final Color? normalIconColor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bookmarkedList.listenable(),
      builder: (context, dynamic value, Widget? child) {
        return CircleAvatar(
          backgroundColor: cColors().black22,
          child: IconButton(
              iconSize: iconSize,
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              //alignment: Alignment.centerRight,
              icon: bookmarkedList.keys.contains(games!.id)
                  ? Icon(CupertinoIcons.heart_fill, color: iconColor == null ? cColors().pinkDark : iconColor)
                  : Icon(CupertinoIcons.heart,  color: normalIconColor == null ? cColors().pinkDark: normalIconColor),
              onPressed: () {
                BookmarkService().handleBookmarkIconPressed(games!, scaffoldKey);
              }),
        );
      },
    );
  }
}