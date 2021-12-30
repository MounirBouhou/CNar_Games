import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Policy extends StatefulWidget{
   const Policy({Key? key})  :  super(key: key);

  @override
  _Policy  createState() => _Policy();
}

class _Policy extends State<Policy> {

  @override
  Widget build(BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text('سياسة الخصوصية'),
              elevation: 0,
            ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then((value) =>
              rootBundle.loadString('assets/privacy_policy.md')),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData){
                  return Markdown(
                    data: snapshot.data,
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              },

            ),
          ),
        ),

        ),
      );
  }
}