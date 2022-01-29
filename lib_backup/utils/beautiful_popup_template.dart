// import 'package:cnargames/colors/custom_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_beautiful_popup/main.dart';
//
// class HomeTemplate extends BeautifulPopupTemplate {
//   final BeautifulPopup options;
//   HomeTemplate(this.options) : super(options);
//
//   @override
//   final illustrationKey = '';
//   @override
//   Color get primaryColor => cColors().blue; // The default primary color of the template is Colors.black.
//   @override
//   final maxWidth = 400; // In most situations, the value is the illustration size.
//   @override
//   final maxHeight = 600;
//   @override
//   final bodyMargin = 10;
//
//   @override
//   BeautifulPopupButton get button {
//     return ({
//       required String label,
//       required void Function() onPressed,
//       bool outline = false,
//       bool flat = false,
//       TextStyle labelStyle = const TextStyle(),
//     }) {
//       final gradient = LinearGradient(colors: [
//         primaryColor.withOpacity(1),
//         primaryColor,
//       ]);
//       final double elevation = (outline || flat) ? 0 : 2;
//       final labelColor =
//       (outline || flat) ? primaryColor : Colors.white.withOpacity(0.95);
//       final decoration = BoxDecoration(
//         gradient: (outline || flat) ? null : gradient,
//         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//         border: Border.all(
//           color: outline ? primaryColor : Colors.transparent,
//           width: (outline && !flat) ? 1 : 0,
//         ),
//       );
//       final minHeight = 40.0 - (outline ? 4 : 0);
//       return RaisedButton(
//         color: Colors.transparent,
//         elevation: elevation,
//         highlightElevation: 0,
//         splashColor: Colors.transparent,
//         child: Ink(
//           decoration: decoration,
//           child: Container(
//             constraints: BoxConstraints(
//               minWidth: 100,
//               minHeight: minHeight,
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.white.withOpacity(0.95),
//                 fontWeight: FontWeight.bold,
//               ).merge(labelStyle),
//             ),
//           ),
//         ),
//         padding: EdgeInsets.all(0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50),
//         ),
//         onPressed: onPressed,
//       );
//     };
//   }
//
//   // You need to adjust the layout to fit into your illustration.
//   @override
//   get layout {
//     return [
//       //Positioned(
//       //  left: percentW(5),
//       //  right: percentW(5),
//       //  child: background,
//       //),
//       Positioned(
//         top: percentH(26),
//         child: title,
//       ),
//       Positioned(
//         top: percentH(36),
//         left: percentW(5),
//         right: percentW(5),
//         height: percentH(actions == null ? 60 : 50),
//         child: content,
//       ),
//       Positioned(
//         bottom: percentW(5),
//         left: percentW(5),
//         right: percentW(5),
//         child: actions ?? Container(),
//       ),
//     ];
//   }
// }