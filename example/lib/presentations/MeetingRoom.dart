import 'package:flutter/material.dart';
import './ScreenUtils/DropDownButton.dart';

class MeetingRoom extends StatefulWidget {
  const MeetingRoom({Key key}) : super(key: key);

  @override
  _MeetingRoomState createState() => _MeetingRoomState();
}

class _MeetingRoomState extends State<MeetingRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0.0,
        leading: DropDownBtn(),
        leadingWidth: 70.0,
        actions: [
          Icon(Icons.volume_up_rounded,color: Colors.blueAccent,size: 30.0,),
          SizedBox(width: 15.0,),
          Icon(Icons.flip_camera_ios,color: Colors.blueAccent,size: 30.0,),
          SizedBox(width: 15.0,),
          Icon(Icons.settings,color: Colors.blueAccent,size: 30.0,),
          SizedBox(width: 15.0,),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(elevation:0.0,items: [
        BottomNavigationBarItem(icon: Icon(Icons.video_call,color: Colors.blue),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.mic,color: Colors.blue),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble,color: Colors.blue,),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.call_end,color: Colors.red,),label: ""),

      ]),
    );
  }
}
