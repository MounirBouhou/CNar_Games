import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cnargames/config/ad_config.dart';

class AdsBloc extends ChangeNotifier {


  int _clickCounter = 0;
  int get clickCounter => _clickCounter;

  bool _isAdLoaded = false;
  bool get isAdLoaded => _isAdLoaded;

  InterstitialAd? _interstitialAd;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  /// Interstitial_Ads **/
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdConfig().getInterstitialAdUnitId(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad ------------>InterstitialAd loaded');
            _interstitialAd = ad;
            _isAdLoaded = true;
            notifyListeners();
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('${error.runtimeType} ---------------->  failed to load: $error.');
            _interstitialAd = null;
            _isAdLoaded = false;
            notifyListeners();
            _createInterstitialAd();
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  /// Rewarded_Ads **/
  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId:  AdConfig().getRewardedVideoAdUnitId(),
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad RewardedAd loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd is failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
  }

  //
  // showLoadedAds() {
  //   _increaseClickCounter();
  //   //_showAd();
  // }

  void showInterstitialAd(){
    _increaseClickCounter();
    if (_isAdLoaded) {
      if (_clickCounter % AdConfig().userClickAmountsToShowEachAd == 0) {
        _showInterstitialAd();
      }
  }
  }

  void showRewardedAd() {
    _increaseClickCounter();
    if (_isAdLoaded) {
      if (_clickCounter % AdConfig().userClickAmountsToShowEachAd == 0) {
        _showRewardedAd();
      }
    }
  }

  void _increaseClickCounter() {
    _clickCounter++;
    debugPrint('Clicks : $_clickCounter');
    notifyListeners();
  }

  //enable only one
  initiateAds (){
    _createInterstitialAd();
    _createRewardedAd();
  }

  //enable only one
  @override
  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }
}
