import 'dart:async';
import 'package:cnargames/colors/custom_colors.dart';
import 'package:cnargames/models/games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PlayGame extends StatefulWidget {
  final String? tag;
  final Games? gamesData;

  const PlayGame({Key? key, this.tag, required this.gamesData})
      : super(key: key);

  @override
   _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<PlayGame> with WidgetsBindingObserver{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();



  @override
  void dispose() {
    super.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      ]);

    WidgetsBinding.instance!.removeObserver(this);
  }



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      print("resumed _________________________________________________________________________");
    }else if(state == AppLifecycleState.inactive){
      // app is inactive
      print("inactive_________________________________________________________________________");
    }else if(state == AppLifecycleState.paused){
      // user is about quit our app temporally
      print("paused_________________________________________________________________________");
    }
  }


  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final Games? gamz = widget.gamesData;

    var w = int.parse(gamz!.width!);
    var h = int.parse(gamz.height!);
    if ( w > h ) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }


      return Scaffold(
        backgroundColor: cColors().blueDark,
          key: scaffoldKey,
          body: Builder(
              builder: (BuildContext context) {
            return WebView(
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
               initialUrl: gamz.game,
              javascriptMode: JavascriptMode.unrestricted,
             // onWebViewCreated: (controller) => _n = controller,
              // onWebViewCreated: (WebViewController wc){
              //    _controller.complete(wc);

              onProgress: (int p){
                 Container(
                   child: Text('Loading: $p', style: TextStyle(fontSize: 50),),
                 );
              },
            );
          }),
      );
  }
}


