import "package:firebase_admob/firebase_admob.dart";

class AdMobService{
  String getAdMobAppID(){
    return "ca-app-pub-3940256099942544~3347511713";
  }
  String getBannerAdID(){
   return "ca-app-pub-3940256099942544/6300978111";
  }
  String getInterstitialAdID(){
    return "ca-app-pub-3940256099942544/1033173712";
  }


  InterstitialAd getInterAd(){
    return InterstitialAd(
      adUnitId: getInterstitialAdID(),
    );
  }


}