// import 'dart:ui';
// import 'package:cnargames/blocs/new_games_bloc.dart';
// import 'package:cnargames/colors/custom_colors.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class RetryGames extends StatefulWidget {
//   const RetryGames({Key? key}) : super(key: key);
//   _RetryGames createState() => _RetryGames();
// }
//
// class _RetryGames extends State<RetryGames> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//
//         child: Stack(
//           children: <Widget>[
//
//             Container(
//               alignment: Alignment.center,
//               child: Text("جهازك الآن متصل بالشبكة", style: TextStyle(
//                   color: cColors().gray,
//                   fontSize: 25, fontWeight: FontWeight.w700
//               ),),
//             ),
//
//             CupertinoButton(
//               pressedOpacity: 0.4,
//               color: cColors().yellowDark,
//               child: Text('هيا نلعب', style: TextStyle(
//                   color: cColors().blueDark,
//                   fontSize: 25, fontFamily: 'Cairo', fontWeight: FontWeight.w700
//               ),),
//               onPressed: (){
//
//                   context.read<NewGamesBloc>().getGames();
//                  // getGames = context.read<NewGamesBloc>().getGames();
//
//               },
//             ),
//
//             Positioned.fill(
//               child: Image.asset(
//                 "assets/images/okNet.png",
//                 fit: BoxFit.fitWidth,
//                 alignment: Alignment.bottomRight,
//               ),
//             )
//
//
//           ],
//         ),
//
//     );
//   }
// }
