
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hmssdk_flutter/models/hms_config.dart';

class HmssdkFlutter {
  static const MethodChannel _channel =
      const MethodChannel('hmssdk_flutter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');

    return version;
  }

  Future<Void?> joinMeeting1(HMSConfig hmsConfig) async{
    debugPrint("ass");
    await _channel.invokeMethod('joinMeeting',hmsConfig.toMap());
  }

  Future<Void?> leaveMeeting() async{
    await _channel.invokeMethod('leaveMeeting');
  }
}
