import "package:firebase_admob/firebase_admob.dart";

class AdMobService{
  String getAdMobAppID(){
    return "ca-app-pub-2590139931654449~2345387423";
  }
  String getBannerAdID(){
   return "ca-app-pub-2590139931654449/9221317773";
  }
  String getInterstitialAdID(){
    return "ca-app-pub-2590139931654449/8607543448";
  }


  InterstitialAd getInterAd(){
    return InterstitialAd(
      adUnitId: getInterstitialAdID(),
    );
  }


}