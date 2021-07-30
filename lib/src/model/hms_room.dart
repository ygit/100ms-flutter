import 'package:hmssdk_flutter/src/model/hms_peer.dart';

/// This class is responsible for providing connected room details
class HMSRoom {
  final String id;
  final String name;
  final String? metaData;

  /// This holds list of app peers
  final List<HMSPeer> peers;

  /// Creates a new [HMSRoom]
  HMSRoom(
      {required this.id,
      required this.name,
      required this.peers,
      this.metaData});

  factory HMSRoom.fromMap(Map map) {
    return HMSRoom(
        id: map['id'],
        name: map['name'],
        peers: HMSPeer.fromListOfMap(map['peers'] ?? []),
        metaData: map['meta_data']);
  }
}
