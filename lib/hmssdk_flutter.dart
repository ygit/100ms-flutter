
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:hmssdk_flutter/models/hms_config.dart';

class HmssdkFlutter {
  static const MethodChannel _channel =
      const MethodChannel('hmssdk_flutter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Void?> joinMeeting(HMSConfig hmsConfig) async{
    await _channel.invokeMethod('joinMeeting',hmsConfig.toMap());
  }

  static Future<Void?> leaveMeeting() async{
    await _channel.invokeMethod('leaveMeeting');
  }
}
