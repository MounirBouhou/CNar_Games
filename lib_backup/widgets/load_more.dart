import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/config/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  const LoadMore({
    Key? key,
    required this.loading,
  }) : super(key: key);

  final bool? loading;

  Widget build(BuildContext context) {
    return Visibility(
        visible: loading == true ? true : false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 19.2, right: 70),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).iconTheme.color,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                            color: cColors().darkGray,
                            strokeWidth: 2.5),
            ),
          ),
        ),
    );
  }
}
