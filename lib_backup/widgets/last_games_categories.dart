import 'package:cnargames/blocs/category_games.dart';
import 'package:cnargames/cards/card_category.dart';
import 'package:cnargames/models/category.dart';
import 'package:cnargames/pages/category_based_games.dart';
import 'package:cnargames/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class LastCategories extends StatelessWidget {
  final List<mCategory> catz;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LastCategories(
      {Key? key,
        required this.catz,
        required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width - 2;

    return catz.isEmpty
        ? ClipRRect(
      // show only empty squares, basically is like a loading
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 11.0, horizontal: 8.0),
        height: 100,
        width: itemWidth,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Stack(
                  children:[
                    Container(
                      width: 68,
                      height: 80,
                      child: Card(
                        //color: getRanColors(),
                       // color: cColors().bg,
                        elevation: 0,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ]
              );
            }),
      ),
    )
        : ClipRRect(
      // show the cat images
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 11.0, horizontal: 8.0),
        height: 100,
        width: itemWidth,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: catz.length,
            itemBuilder: (context, index) {
              var mc = catz[index];
              return InkWell(
                  child: CardCategory(
                    cat: mc,
                    // heroTag: '${mc.id}',
                    scaffoldKey: scaffoldKey,
                  ),
                  onTap: () {
                    nextScreen(
                        context,
                        CategoryBasedGames(
                            catName: catz[index].name,
                           // catId: catz[index].id,
                            catThumb: catz[index].thumb
                        ));
                    context.read<CategoryGamesBloc>().catID('${catz[index].id}');
                  });
            }),
      ),
    );
  }
}
