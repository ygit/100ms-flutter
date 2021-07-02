

import 'package:flutter/services.dart';

class Untitled {
  static const MethodChannel _channel =
      const MethodChannel('untitled');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  
  static void joinMeet(String userName,String tokenKey) async{
    await _channel.invokeMethod('joinMeet',{"userName":userName,"tokenID":tokenKey});
  }

  static void leave() async{
    await _channel.invokeMethod('leave');
  }
}
