import 'package:flutter/material.dart';


class ScrollToTop extends StatelessWidget {
  const ScrollToTop({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).iconTheme.color,
      onPressed: _scrollToTop,
      child: Icon(Icons.keyboard_arrow_up_sharp, size: 30,),
      mini: true,
    );
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    controller!.animateTo(1, duration: Duration(milliseconds: 1300), curve: Curves.linearToEaseOut);
  }
}
