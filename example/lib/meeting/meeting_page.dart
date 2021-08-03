import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hmssdk_flutter/enum/hms_track_kind.dart';
import 'package:hmssdk_flutter/enum/hms_track_source.dart';
import 'package:hmssdk_flutter/model/hms_track.dart';
import 'package:hmssdk_flutter_example/common/ui/organisms/chat_bottom_sheet.dart';
import 'package:hmssdk_flutter_example/common/ui/organisms/peer_item_organism.dart';
import 'package:hmssdk_flutter_example/enum/meeting_flow.dart';
import 'package:hmssdk_flutter_example/main.dart';
import 'package:hmssdk_flutter_example/meeting/meeting_controller.dart';
import 'package:hmssdk_flutter_example/meeting/meeting_store.dart';

class MeetingPage extends StatefulWidget {
  final String roomId;
  final MeetingFlow flow;
  final String user;

  const MeetingPage(
      {Key? key, required this.roomId, required this.flow, required this.user})
      : super(key: key);

  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  late MeetingStore _meetingStore;

  @override
  void initState() {
    _meetingStore = MeetingStore();
    MeetingController meetingController = MeetingController(
        roomId: widget.roomId, flow: widget.flow, user: widget.user);
    _meetingStore.meetingController = meetingController;

    super.initState();
    initMeeting();
  }

  void initMeeting() {
    _meetingStore.joinMeeting();
    _meetingStore.startListen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomId),
        actions: [
          Observer(
              builder: (_) => IconButton(
                    onPressed: () {
                      _meetingStore.toggleSpeaker();
                    },
                    icon: Icon(_meetingStore.isSpeakerOn
                        ? Icons.volume_up
                        : Icons.volume_off),
                  )),
          IconButton(
            onPressed: () async {
              _meetingStore.toggleCamera();
            },
            icon: Icon(Icons.switch_camera),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.settings),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Observer(builder: (_) {
              if (_meetingStore.localPeer != null) {
                return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: PeerItemOrganism(
                    track: HMSTrack(
                        trackDescription: '',
                        source: HMSTrackSource.kHMSTrackSourceRegular,
                        kind: HMSTrackKind.unknown,
                        trackId: '',
                        peer: _meetingStore.localPeer),
                  ),
                );
              } else {
                return Text('No Local peer');
              }
            }),
            Flexible(
              child: Observer(
                builder: (_) {
                  if (!_meetingStore.isMeetingStarted) return SizedBox();
                  if (_meetingStore.tracks.isEmpty)
                    return Text('Waiting for other to join!');
                  List<HMSTrack> filteredList = _meetingStore.tracks
                      .where((element) =>
                          element.kind != HMSTrackKind.kHMSTrackKindAudio)
                      .toList();
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: List.generate(
                        filteredList.length,
                        (index) =>
                            PeerItemOrganism(track: filteredList[index])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Observer(builder: (context) {
              return IconButton(
                  tooltip: 'Video',
                  onPressed: () {
                    _meetingStore.toggleVideo();
                  },
                  icon: Icon(_meetingStore.isVideoOn
                      ? Icons.videocam
                      : Icons.videocam_off));
            }),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Observer(builder: (context) {
              return IconButton(
                  tooltip: 'Audio',
                  onPressed: () {
                    _meetingStore.toggleAudio();
                  },
                  icon:
                      Icon(_meetingStore.isMicOn ? Icons.mic : Icons.mic_off));
            }),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: IconButton(
                tooltip: 'Chat',
                onPressed: () {
                  chatMessages(context, _meetingStore);
                },
                icon: Icon(Icons.chat_bubble)),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: IconButton(
                tooltip: 'Leave',
                onPressed: () {
                  _meetingStore.meetingController.leaveMeeting();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (ctx) => HomePage()));
                },
                icon: Icon(Icons.call_end)),
          ),
        ],
      ),
    );
  }
}
