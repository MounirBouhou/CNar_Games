// import 'dart:ui';
//
// import 'package:cnargames/colors/custom_colors.dart';
// import 'package:cnargames/models/games.dart';
// import 'package:cnargames/pages/play_game.dart';
// import 'package:cnargames/utils/custom_cache_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'constants.dart';
//
// class GameDialog extends StatefulWidget {
//   //final String title;
//   final Games? games;
//
//   const GameDialog({Key? key, required this.games}) : super(key: key);
//
//   @override
//   _GameDialogState createState() => _GameDialogState();
// }
//
// class _GameDialogState extends State<GameDialog> {
//
//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   Navigator.of(context).pop();
//   // }
//   // @override
//   // void deactivate() {
//   //   super.deactivate();
//   //   //Navigator.of(context).pop();
//   // }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(Constants.padding),
//       ),
//       elevation: 0,
//       alignment: Alignment.center,
//       backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }
//   contentBox(context){
//     final Games? gm = widget.games;
//     return Stack(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
//               + Constants.padding, right: Constants.padding,bottom: Constants.padding
//           ),
//           margin: EdgeInsets.only(top: 100),
//           decoration: BoxDecoration(
//               shape: BoxShape.rectangle,
//               color: cColors().bg,
//               borderRadius: BorderRadius.circular(Constants.padding),
//               boxShadow: [
//                 BoxShadow(color: Colors.black87,offset: Offset(20,10),
//                     blurRadius: 50
//                 ),
//               ]
//           ),
//
//     child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(gm!.title!,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
//               SizedBox(height: 1,),
//               Text(gm.category!,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
//               Align(
//                 alignment: Alignment.center,
//                 child: FlatButton(
//                     onPressed: () async {
//                       Navigator.of(context).pop();
//
//                       await Navigator.push(context, MaterialPageRoute(
//                           builder: (context) => PlayGame(tag: 'tag', gamesData: gm)
//                       ));
//
//                     },
//                     child: Text("إلعب",style: TextStyle(fontSize: 18),)),
//               ),
//               SizedBox(height: 20,),
//               Text(gm.content!,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
//               SizedBox(height: 20,),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: FlatButton(
//                     onPressed: (){
//                       Navigator.of(context).pop();
//                     },
//                     child: Text("أغلق",style: TextStyle(fontSize: 18),)),
//               ),
//
//
//
//
//             ],
//           ),
//           ),
//         ),
//
//         Positioned(
//           height: 200,
//           top: 0,
//           left: Constants.padding,
//           right: Constants.padding,
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: Constants.avatarRadius,
//             child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//                 child: CustomCacheImage(img: gm.image!, w: 200, h: 260,),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }