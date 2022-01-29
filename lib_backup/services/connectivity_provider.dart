import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider extends ChangeNotifier{

  Connectivity _connectivity = new Connectivity();
  bool _isOnline = false;
  bool get isOnline => _isOnline;

  startMonitoring() async {
      await initConnectivity();
      _connectivity.onConnectivityChanged.listen((result) async {
        if (result == ConnectivityResult.none){
          _isOnline = false;
          notifyListeners();
        } else {
           await updateConnectionStatus().then((bool? isConnected){
             _isOnline = isConnected!;
              notifyListeners();
           });
        }
      });


  }

  Future<void> initConnectivity() async{
    try{
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none){
          _isOnline = false;
          notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e){
       print("P = " + e.toString());
    }
  }


  Future<bool?> updateConnectionStatus() async {
    bool? isConnected;
    try{
      final List<InternetAddress> r = await InternetAddress.lookup("google.com");
      if (r.isNotEmpty && r[0].rawAddress.isNotEmpty){
        isConnected = true;
      }
    } on SocketException catch (_) {
         isConnected = false;
    }

    return isConnected;
  }



}