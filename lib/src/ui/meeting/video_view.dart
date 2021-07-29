import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show StandardMessageCodec;
import 'package:hmssdk_flutter/src/model/hms_track.dart';

class VideoView extends StatelessWidget {
  /// This is used to fetch video for a user
  final HMSTrack track;

  /// This includes arguments that are sent to platform
  final Map<String, Object>? args;

  /// Creates a view with video stream
  ///
  /// It returns back the view from platform(android, ios) which can be used to show video in app
  const VideoView(
      {Key? key, required this.track, this.args, this.onViewCreated})
      : super(key: key);
  final Function? onViewCreated;

  /// This is used to call callback function sent by user. It will only be called after view is built
  void onPlatformViewCreated(int id) {
    if (onViewCreated != null) onViewCreated!();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'HMSVideoView',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: StandardMessageCodec(),
        creationParams: {
          'peer_id': track.peer?.peerId,
          'is_local': track.peer?.isLocal,
          'track_id': track.trackId
        }..addAll(args ?? {}),
        gestureRecognizers: {},
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'HMSVideoView',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: StandardMessageCodec(),
        creationParams: {
          'peer_id': track.peer?.peerId,
          'is_local': track.peer?.isLocal,
          'track_id': track.trackId
        }..addAll(args ?? {}),
        gestureRecognizers: {},
      );
    } else {
      throw UnimplementedError(
          'Video View is not implemented for this platform ${Platform.localHostname}');
    }
  }
}
