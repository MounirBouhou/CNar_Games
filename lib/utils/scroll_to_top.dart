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
      onPressed: _scrollToTop,
      child: Icon(Icons.arrow_upward),
      mini: true,
    );
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    controller!.animateTo(1, duration: Duration(seconds: 2), curve: Curves.linearToEaseOut);
  }
}
