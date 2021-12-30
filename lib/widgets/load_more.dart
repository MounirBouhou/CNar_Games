import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  const LoadMore({
    Key? key,
    required this.loading,
    required this.color,
  }) : super(key: key);

  final bool? loading;
  final Color color;

  Widget build(BuildContext context) {
    return Visibility(
      visible: loading == true ? true : false,
      child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                  color: color,
                  strokeWidth: 2),
              SizedBox(
                width: 18,
              ),
              Text(
                'جار تحميل المزيد...',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: color),
              ),
            ],
          )),
    );
  }
}
