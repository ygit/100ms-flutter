import 'package:flutter/material.dart';
import 'package:hmssdk_flutter/exceptions/hms_exception.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:hmssdk_flutter/models/hms_room.dart';
import 'package:hmssdk_flutter_example/presentations/meet_login.dart';
import 'screen_utils/drop_down_btn.dart';

class MeetingRoom extends StatefulWidget {
  final HMSRoom hmsRoom;

  const MeetingRoom(this.hmsRoom) : super();

  @override
  _MeetingRoomState createState() => _MeetingRoomState();
}

class _MeetingRoomState extends State<MeetingRoom> {
  var switching = [true, true];
  var nameOfPerson="";
  var hms_sdk, hms_listener;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0.0,
        leading: DropDownBtn(),
        leadingWidth: 70.0,
        actions: [
          Icon(
            Icons.volume_up_rounded,
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SizedBox(
            width: 15.0,
          ),
          Icon(
            Icons.flip_camera_ios,
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SizedBox(
            width: 15.0,
          ),
          Icon(
            Icons.settings,
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(switching[0] ? Icons.video_call : Icons.videocam_off,
                  color: Colors.blue),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(switching[1] ? Icons.mic : Icons.mic_off,
                  color: Colors.blue),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_bubble,
                color: Colors.blue,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.call_end,
                color: Colors.red,
              ),
              label: ""),
        ],
        onTap: (index) => {
          if (index == 0)
            {
              debugPrint(switching[0].toString()),
              setState(() {
                switching[0] = !switching[0];
                debugPrint(switching[0].toString());
              })
            }
          else if (index == 1)
            {
              setState(() {
                switching[1] = !switching[1];
              })
            }
          else if (index == 2)
            {}
          else
            {
              hms_sdk.leaveMeetingAndroid(),
              hms_listener.onDisconnectedAndroid(),
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>MeetLogIn()))
            }
        },
      ),
      body: Center(
        child: Text(widget.hmsRoom.name),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //hms_sdk.leaveMeetingAndroid();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    hms_listener = MeetingRoomListener(context: context);
    hms_sdk = HmssdkFlutter(
        onreconnectingAndroid: hms_listener.onReconnectingAndroid,
        onReconnectedAndroid: hms_listener.onReconnectedAndroid);
    super.initState();
  }


}

class MeetingRoomListener {
  BuildContext context;

  MeetingRoomListener({required this.context}){
    debugPrint("MeetingRoomListener");
  }

  void onReconnectedAndroid() {
    debugPrint("onReconnectedAndroid");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("reconnected")));
  }


  void onReconnectingAndroid(HMSException hmsException) {
    debugPrint("onReconnectingAndroid");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("reconnecting "+hmsException.message)));
  }

  void onDisconnectedAndroid(){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("You have Left the meeting")));
  }

}
