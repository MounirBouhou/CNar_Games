


import 'dart:io';

class AppServices {

  // check for connectivity
  Future<bool?> checkInternet() async{
    bool? internet;
    try{
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        internet = true;
      }
    } on SocketException catch (_){
      internet = false;
    }
    return internet;
  }





}