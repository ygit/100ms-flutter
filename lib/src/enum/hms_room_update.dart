enum HMSRoomUpdate {
  roomMuted,
  roomUnmuted,
  serverRecordingStateUpdated,
  browserRecordingStateUpdated,
  rtmpStreamingStateUpdated,
  hlsStreamingStateUpdated,
  RoomIdUpdated,
  RoomNameUpdated,
  RoomPeerCountUpdated,
  defaultUpdate
}

extension HMSRoomUpdateValues on HMSRoomUpdate {
  static HMSRoomUpdate getHMSRoomUpdateFromName(String name) {
    switch (name) {
      case 'room_muted':
        return HMSRoomUpdate.roomMuted;

      case 'room_unmuted':
        return HMSRoomUpdate.roomUnmuted;

      case 'server_recording_state_updated':
        return HMSRoomUpdate.serverRecordingStateUpdated;

      case 'browser_recording_state_updated':
        return HMSRoomUpdate.browserRecordingStateUpdated;

      case 'rtmp_streaming_state_updated':
        return HMSRoomUpdate.rtmpStreamingStateUpdated;

      case 'hls_streaming_state_updated':
        return HMSRoomUpdate.hlsStreamingStateUpdated;

      case "room_name_updated":
        return HMSRoomUpdate.RoomNameUpdated;

      case "room_peer_count_updated":
        return HMSRoomUpdate.RoomPeerCountUpdated;

      case "room_id_updated":
        return HMSRoomUpdate.RoomIdUpdated;

      default:
        return HMSRoomUpdate.defaultUpdate;
    }
  }

  static String getValueFromHMSRoomUpdate(HMSRoomUpdate hmsRoomUpdate) {
    switch (hmsRoomUpdate) {
      case HMSRoomUpdate.roomMuted:
        return 'room_muted';

      case HMSRoomUpdate.roomUnmuted:
        return 'room_unmuted';

      case HMSRoomUpdate.serverRecordingStateUpdated:
        return 'server_recording_state_updated';

      case HMSRoomUpdate.browserRecordingStateUpdated:
        return 'browser_recording_state_updated';

      case HMSRoomUpdate.rtmpStreamingStateUpdated:
        return 'rtmp_streaming_state_updated';

      case HMSRoomUpdate.hlsStreamingStateUpdated:
        return 'hls_streaming_state_updated';

      case HMSRoomUpdate.RoomNameUpdated:
        return "room_name_updated";

      case HMSRoomUpdate.RoomPeerCountUpdated:
        return "room_peer_count_updated";

      case HMSRoomUpdate.RoomIdUpdated:
        return "room_id_updated";

      default:
        return 'defaultUpdate';
    }
  }
}
