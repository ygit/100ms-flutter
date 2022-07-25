import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:hmssdk_flutter_example/common/ui/organisms/video_tile.dart';
import 'package:hmssdk_flutter_example/meeting/peer_track_node.dart';
import 'package:provider/provider.dart';

class OneToOneMode extends StatefulWidget {
  final List<PeerTrackNode> peerTracks;
  final BuildContext context;
  final Size size;
  final int screenShareCount;
  const OneToOneMode(
      {Key? key,
      required this.peerTracks,
      required this.context,
      required this.size,
      required this.screenShareCount})
      : super(key: key);

  @override
  State<OneToOneMode> createState() => _OneToOneModeState();
}

class _OneToOneModeState extends State<OneToOneMode> {
  @override
  Widget build(BuildContext context) {
    PeerTrackNode localPeer =
        widget.peerTracks.firstWhere((element) => element.peer.isLocal);
    PeerTrackNode remotePeer =
        widget.peerTracks.firstWhere((element) => !element.peer.isLocal);
    // EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ChangeNotifierProvider.value(
              key: ValueKey(remotePeer.uid + "video_view"),
              value: remotePeer,
              child: VideoTile(
                itemHeight: widget.size.height,
                itemWidth: widget.size.width,
              ),
            ),
            DraggableWidget(
              topMargin: 10,
              bottomMargin: 230,
              horizontalSpace: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: ChangeNotifierProvider.value(
                    key: ValueKey(localPeer.uid + "video_view"),
                    value: localPeer,
                    child: VideoTile(
                      itemHeight: 150,
                      itemWidth: 100,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
