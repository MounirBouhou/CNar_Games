import 'dart:async';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:cnargames/config/config.dart';

class AppServices {

  Future openEmailSupport() async {
    await urlLauncher.launch(
        'mailto:${Config().supportEmail}?subject=About ${Config().appName} App&body=');
  }

}
