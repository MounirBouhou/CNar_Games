// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'dart:async';
// import 'package:cnargames/config/ad_config.dart';
//
// class AdsBloc extends ChangeNotifier {
//
//   int _clickCounter = 0;
//   int get clickCounter => _clickCounter;
//
//   bool _isAdLoaded = false;
//   bool get isAdLoaded => _isAdLoaded;
//
//   InterstitialAd? _interstitialAd;
//
//   void createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: AdConfig().getInterstitialAdUnitId(),
//         request: AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//              onAdLoaded: (Ad ad) {
//                   print('${ad.runtimeType} +++++++++++++++++ loaded.');
//                   _isAdLoaded = true;
//                   notifyListeners();
//              },
//
//             onAdFailedToLoad: (LoadAdError error) {
//               print('+++++++++++++++++ failed to load: $error.');
//               _interstitialAd = null;
//               _isAdLoaded = false;
//               notifyListeners();
//               createInterstitialAd();
//               },
//
//         )
//     ).onError((error, stackTrace) => print('+++++++++ error loading ads : $error'));
//   }
//
//
//   // RewardedAd? _rewardedAd;
//   //
//   // void createRewardedVideoAd() {
//   //   _rewardedAd ??= RewardedAd(
//   //     adUnitId: AdConfig().getRewardedVideoAdUnitId(),
//   //     request: AdRequest(),
//   //     listener: AdListener(
//   //         onAdLoaded: (Ad ad) {
//   //           print('${ad.runtimeType} loaded.');
//   //           _isAdLoaded = true;
//   //           notifyListeners();
//   //         },
//   //         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//   //           print('${ad.runtimeType} failed to load: $error.');
//   //           ad.dispose();
//   //           _rewardedAd = null;
//   //           _isAdLoaded = false;
//   //           notifyListeners();
//   //           createRewardedVideoAd();
//   //         },
//   //         onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
//   //         onAdClosed: (Ad ad) {
//   //           print('${ad.runtimeType} closed.');
//   //           ad.dispose();
//   //           _rewardedAd = null;
//   //           _isAdLoaded = false;
//   //           notifyListeners();
//   //           createRewardedVideoAd();
//   //         },
//   //         onApplicationExit: (Ad ad) => print('${ad.runtimeType} onApplicationExit.'),
//   //         onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
//   //           print('$RewardedAd with reward $RewardItem(${reward.amount}, ${reward.type})',);
//   //         }
//   //     ),
//   //   )..load();
//   // }
//
//
//   //enable only one
//   void _showAd() {
//     if (_isAdLoaded) {
//       if (_clickCounter % AdConfig().userClickAmountsToShowEachAd == 0) {
//         _interstitialAd!.show();
//         //_rewardedAd.show();
//       }
//     }
//   }
//
//   void _increaseClickCounter() {
//     _clickCounter++;
//     debugPrint('Clicks : $_clickCounter');
//     notifyListeners();
//   }
//
//
//
//   //enable only one
//   initiateAds (){
//     createInterstitialAd();
//     //createRewardedVideoAd();
//   }
//
//   showLoadedAds() {
//     _increaseClickCounter();
//     _showAd();
//   }
//
//
//   //enable only one
//   @override
//   void dispose() {
//     _interstitialAd?.dispose();
//     //_rewardedAd?.dispose();
//     super.dispose();
//   }
// }
