
import 'dart:async';
import 'dart:ffi';


import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hmssdk_flutter/exceptions/hms_exception.dart';
import 'package:hmssdk_flutter/models/hms_config.dart';
import 'package:hmssdk_flutter/models/hms_room.dart';

class HmssdkFlutter {
  static const MethodChannel _channel =
      const MethodChannel('hmssdk_flutter');

  Function? onJoinAndroid;
  Function? onreconnectingAndroid;
  Function? onReconnectedAndroid;
  

  HmssdkFlutter({this.onJoinAndroid,this.onreconnectingAndroid,this.onReconnectedAndroid}){
    listenToPlatformCalls();
  }

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');

    return version;
  }

  Future<Void?> joinMeetingAndroid(HMSConfig hmsConfig) async{
    debugPrint("ass");
    await _channel.invokeMethod('joinMeeting',hmsConfig.toMap());

  }


  Future<Void?> leaveMeetingAndroid() async{
    await _channel.invokeMethod('leaveMeeting');
  }

  void listenToPlatformCalls() {
    _channel.setMethodCallHandler((call) async {
      print(call.method+"HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
      dynamic args=call.arguments;
      switch (call.method) {
        case "onJoinAndroid":

          dynamic hms=HMSRoom(args["roomId"], args["name"]);
          onJoinAndroid!(hms);
          break;
        case "onPeerUpdate":
          print(call.method);
          break;
        case "onRoomUpdate":
          print(call.method);
          break;
        case "onTrackUpdate":
          print(call.method);
          break;
        case "onMessageReceived":
          print(call.method);
          break;
        case "onErrorAndroid":
          print(call.method);
          break;
        case "onReconnectingAndroid":
          debugPrint("OOOOOOOOOOOOOOOOOOOOOOOOOOOONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNREEEEEEEEEEEEEEEEEEEEEEEEEEEECONNNNNNNNNNNNNNNNNNNNECTING");
          HMSException hms=HMSException(code: args["code"], message: args["message"], name: args["name"], action: args["action"], description: args["description"]);
          onreconnectingAndroid!(hms);
          break;
        case "onReconnectedAndroid":
          print(call.method);
          onReconnectedAndroid!();
          break;
        default:
          print('No method found');
          break;
      }
    });
  }
}
