import 'package:cnargames/cards/card_game.dart';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/models/games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading.dart';

class LastGames extends StatelessWidget {
  final List<Games> gamz;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LastGames({Key? key, required this.gamz, required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        gamz.isEmpty
            ? loading(context)
            : Column(
                children: [
                  ListTile(
                    //tileColor: cColors().yellow,
                    contentPadding: EdgeInsets.only(right: 20, left: 20),
                    leading: Container(
                      //alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        decoration: new BoxDecoration(
                          color: cColors().gray,
                          shape: BoxShape.circle,
                         // borderRadius: new BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          CupertinoIcons.game_controller_solid,
                          size: 22,
                          color: cColors().pinkDark,
                        )),
                    horizontalTitleGap: 15,
                    enabled: false,
                    title: Text(
                      'جديد الألعاب',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: cColors().gray
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // AppService().openLinkWithCustomTab(context, WpConfig().websiteUrl);
                    },
                  ),
                  Divider(
                    color: cColors().gray,
                    thickness: 3,
                    indent: 20,
                    endIndent: 20,
                  ),

                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(), // important
                    padding: EdgeInsets.all(15),
                    shrinkWrap: true, //important
                    itemCount: gamz.length,
                    itemBuilder: (BuildContext context, int index) {
                      var g = gamz[index];
                      return CardGame(
                          heroTag: '${g.id}',
                          scaffoldKey: scaffoldKey,
                          games: g);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
