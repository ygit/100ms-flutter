import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hms_room_kit/hms_room_kit.dart';
import 'package:hms_room_kit/src/enums/session_store_keys.dart';
import 'package:hms_room_kit/src/meeting/meeting_store.dart';
import 'package:hms_room_kit/src/model/peer_track_node.dart';
import 'package:hms_room_kit/src/widgets/common_widgets/hms_subheading_text.dart';

class LocalPeerBottomSheet extends StatefulWidget {
  final MeetingStore meetingStore;
  final PeerTrackNode peerTrackNode;

  const LocalPeerBottomSheet(
      {Key? key, required this.meetingStore, required this.peerTrackNode})
      : super(key: key);
  @override
  State<LocalPeerBottomSheet> createState() => _LocalPeerBottomSheetState();
}

class _LocalPeerBottomSheetState extends State<LocalPeerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.4,
      child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 24, right: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HMSTitleText(
                            text:
                                "${widget.meetingStore.localPeer?.name} (You)",
                            textColor: HMSThemeColors.onSurfaceHighEmphasis,
                            letterSpacing: 0.15,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          HMSSubtitleText(
                              text: widget.meetingStore.localPeer?.role.name ??
                                  "",
                              textColor: HMSThemeColors.onSurfaceMediumEmphasis)
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: HMSThemeColors.onSurfaceHighEmphasis,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Divider(
                  color: HMSThemeColors.borderDefault,
                  height: 5,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                        horizontalTitleGap: 2,
                        onTap: () async {
                          widget.meetingStore
                              .changePinTileStatus(widget.peerTrackNode);
                        },
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          "packages/hms_room_kit/lib/src/assets/icons/pin.svg",
                          semanticsLabel: "fl_local_pin_tile",
                          height: 20,
                          width: 20,
                        ),
                        title: HMSSubheadingText(
                            text: "Pin Tile for Myself",
                            textColor: HMSThemeColors.onSurfaceHighEmphasis)),
                    ListTile(
                        horizontalTitleGap: 2,
                        onTap: () async {
                          if (widget.meetingStore.spotLightPeer?.uid ==
                              widget.peerTrackNode.uid) {
                            widget.meetingStore.setSessionMetadataForKey(
                                key: SessionStoreKeyValues.getNameFromMethod(
                                    SessionStoreKey.spotlight),
                                metadata: null);
                            return;
                          }

                          ///Setting the metadata as audio trackId if it's not present
                          ///then setting it as video trackId
                          String? metadata =
                              (widget.peerTrackNode.audioTrack == null)
                                  ? widget.peerTrackNode.track?.trackId
                                  : widget.peerTrackNode.audioTrack?.trackId;
                          widget.meetingStore.setSessionMetadataForKey(
                              key: SessionStoreKeyValues.getNameFromMethod(
                                  SessionStoreKey.spotlight),
                              metadata: metadata);
                        },
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          "packages/hms_room_kit/lib/src/assets/icons/spotlight.svg",
                          semanticsLabel: "fl_spotlight_local_tile",
                          height: 20,
                          width: 20,
                        ),
                        title: HMSSubheadingText(
                            text: "Spotlight Tile for Everyone",
                            textColor: HMSThemeColors.onSurfaceHighEmphasis)),
                    ListTile(
                        horizontalTitleGap: 2,
                        onTap: () async {
                          ///TODO: Add implementation
                        },
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          "packages/hms_room_kit/lib/src/assets/icons/minimize.svg",
                          semanticsLabel: "fl_minimize_local_tile",
                          height: 20,
                          width: 20,
                        ),
                        title: HMSSubheadingText(
                            text: "Minimize Your Video",
                            textColor: HMSThemeColors.onSurfaceHighEmphasis)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
