import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EmptyPageWithImage extends StatelessWidget {
  const EmptyPageWithImage({
    Key? key,
    required this.image,
    required this.title,
    this.description,
  }) : super(key: key);

  final String image;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                image,
                fit: BoxFit.scaleDown,
                // alignment: Alignment.topCenter,
                height: 200,
                width: 200,
              ),
            ),
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),

              description == null ? Container() :
              Text(
                description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    fontSize: 14),
              )
            ],
          ),
        ),
        // SizedBox(
        //   height: 10,
        // ),


      ],
    );


    // return Container(
    //   padding: EdgeInsets.all(0),
    //   alignment: Alignment.topCenter,
    //   //height: MediaQuery.of(context).size.height / 2,
    //   width: double.infinity,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //   Image.asset(
    //       image,
    //       fit: BoxFit.fill,
    //      // alignment: Alignment.topCenter,
    //       height: 200,
    //       width: 200,
    //     ),
    //
    //       SizedBox(
    //         height: 20,
    //       ),
    //
    //       Text(
    //         title,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
    //       ),
    //       SizedBox(
    //         height: 1,
    //       ),
    //       description == null ? Container() :
    //       Text(
    //         description!,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontWeight: FontWeight.w500,
    //             color: Colors.grey[600],
    //             fontSize: 16),
    //       )
    //     ],
    //   ),
    // );
  }
}
