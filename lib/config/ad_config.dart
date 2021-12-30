
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AdConfig{

  final int userClickAmountsToShowEachAd = 3;

  //final String appIdAndroid = 'ca-app-pub-6420378052243028~1309625048';
  final String appIdAndroid = 'ca-app-pub-3940256099942544~3347511713';
  final String appIdiOS = 'ca-app-pub-3940256099942544~1458002511';

  //final String interstitialAdUnitIdAndroid = 'ca-app-pub-6420378052243028/8279176314';
  final String interstitialAdUnitIdAndroid = 'ca-app-pub-3940256099942544/1033173712';
  final String interstitialAdUnitIdiOS = 'ca-app-pub-3940256099942544/4411468910';

  final String rewardedVideoAdUnitIdAndroid = 'ca-app-pub-3940256099942544/5224354917';
  final String rewardedVideoAdUnitIdiOS = 'ca-app-pub-3940256099942544/1712485313';

 ////Original final String bannerAdUnitIdAndroid = 'ca-app-pub-6420378052243028/1128595989';
 final String bannerAdUnitIdAndroid = 'ca-app-pub-3940256099942544/6300978111';
 final String bannerAdUnitIdiOS = 'ca-app-pub-3940256099942544/2934735716';

  // Do not edit this --

   Future initAdmob() async {
     await MobileAds.instance.initialize();
   }

   String getAdmobAppId() {
     if (Platform.isAndroid){
       return appIdAndroid;
     } else {
       return appIdiOS;
     }
   }

    String getBannerAdUnitId()  {
      if (Platform.isAndroid){
        return bannerAdUnitIdAndroid;
      } else {
        return bannerAdUnitIdiOS;
      }
    }

   String getInterstitialAdUnitId() {
     if(Platform.isAndroid){
       return interstitialAdUnitIdAndroid;
     } else {
       return interstitialAdUnitIdiOS;
     }
   }

   String getRewardedVideoAdUnitId(){
     if(Platform.isAndroid){
       return rewardedVideoAdUnitIdAndroid;
     } else {
       return rewardedVideoAdUnitIdiOS;
     }
   }
}