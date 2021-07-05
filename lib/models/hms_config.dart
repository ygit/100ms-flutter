import 'package:flutter/material.dart';

class HMSConfig {
  final String userName;
  final String userId;
  final String roomId;
  final String authToken;
  final String metaData;

  HMSConfig(
      {this.userName = "UnKnown",
      required this.userId,
      required this.roomId,
      required this.authToken,
      this.metaData=""});

  Map<String,dynamic> toMap(){
    return {
      "userName":userName,
      "userId":userId,
      "roomId":roomId,
      "authToken":authToken,
      "metaData":metaData
    };
  }
}
