

import 'package:cnargames/cards/card_game.dart';
import 'package:cnargames/models/games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LastGames extends StatelessWidget {

  final List<Games> gamz;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LastGames ({
    Key? key,
    required this.gamz, required this.scaffoldKey
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

     return Column(

       crossAxisAlignment: CrossAxisAlignment.start,

       textDirection: TextDirection.rtl,

       // direction: Axis.vertical,
       // mainAxisAlignment: mainAxisAlignment,
       // mainAxisSize: mainAxisSize,
       // crossAxisAlignment: crossAxisAlignment, ++++++++
       // textDirection: textDirection, +++++++++++++++
       // verticalDirection: verticalDirection,
       // textBaseline: textBaseline,

       children: [


         Center(
           child: Padding(padding: const EdgeInsets.only(top: 30, bottom: 30),
           child: Text('جديد الألعاب', style: TextStyle(
             letterSpacing: -0.1, wordSpacing: 1, fontWeight: FontWeight.w100, fontSize: 18
           )),
           ),
         ),



         gamz.isEmpty ? Container(
           child: Center(child: Text("جارٍ التحميل...")),
         ) : ListView.separated(
             scrollDirection: Axis.vertical,
             shrinkWrap: true, //important
             itemBuilder: (BuildContext context, int index){
               final Games g = gamz[index];
               print("ggggggggggg = $g");
               return CardGame(heroTag: '${g.id}', scaffoldKey: scaffoldKey, games: g);
             },
             separatorBuilder: (context, index) => SizedBox(
               height: 15,
             ),
             itemCount: gamz.length
         ),

       ],


     );
  }
}