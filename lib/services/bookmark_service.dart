
import 'package:cnargames/cards/constants.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/strings.dart';
import 'package:cnargames/models/games.dart';
import 'package:cnargames/utils/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BookmarkService {


  final bookmarkedList = Hive.box(Constants.bookmarkTag);

  Future handleBookmarkIconPressed(Games games, scaffoldKey) async {
    if (bookmarkedList.keys.contains(games.id)) {
      removeFromBookmarkList(games);
    } else {
      addToBookmarkList(games);
      openSnacbar(scaffoldKey, st.theGameIsAddedToBookmark, Icons.favorite);
    }
  }

  Future addToBookmarkList (Games games) async {
    await bookmarkedList.put(games.id, {
      'id' : games.id,
      'title' : games.title,
      // 'content' : games.content,
      'image' : games.image,
      'category' : games.category,
      'date' : games.date,
      'catId' : games.catId,
      'game' : games.game,
      'width' : games.width,
      'height' : games.height,
      'views' : games.views
    }
    );
  }

  Future removeFromBookmarkList (Games games) async {
    await bookmarkedList.delete(games.id);
  }

  Future clearBookmarkList () async {
    await bookmarkedList.clear();
  }

  Future sortBookmarkList () async {
     var l = bookmarkedList.toMap();
     print(l);
  }

}

