import 'dart:async';

import 'package:cnargames/config/config.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class AppServices {

  Future openEmailSupport() async {
    await urlLauncher.launch(
        'mailto:${Config().supportEmail}?subject=About ${Config().appName} App&body=');
  }

}
