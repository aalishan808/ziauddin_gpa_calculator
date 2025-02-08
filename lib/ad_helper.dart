import 'dart:io';
class Adhelper{
  static String get bannerAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-5661440107623413/7761689538';
    }

    else{
      throw new UnsupportedError('Unsupported platform');
    }
    
  }
}