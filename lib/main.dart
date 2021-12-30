import 'package:cnargames/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'blocs/ad_state.dart';

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final initFuture = MobileAds.instance.initialize();
    final adState = AdState(initFuture);
    runApp(Provider.value(
      value: adState,
      builder: (context, child) => MyApp(),
    ));
  }






