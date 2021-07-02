import 'package:flutter/material.dart';
import 'package:untitled/untitled.dart';
import './ScreenUtils/DropDownButton.dart';
import 'dart:convert';

class MeetingRoom extends StatefulWidget {
  const MeetingRoom({Key key}) : super(key: key);

  @override
  _MeetingRoomState createState() => _MeetingRoomState();
}

class _MeetingRoomState extends State<MeetingRoom> {

  var switching=[true,true];

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
              icon: Icon(switching[0]?Icons.video_call:Icons.videocam_off, color: Colors.blue), label: ""),
          BottomNavigationBarItem(
              icon: Icon(switching[1]?Icons.mic:Icons.mic_off, color: Colors.blue), label: ""),
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
                  switching[0]=!switching[0];
                  debugPrint(switching[0].toString());
                })
            }
          else if (index == 1)
            {
              setState(() {
                switching[1]=!switching[1];
              })
            }
          else if (index == 2)
            {}
          else
            {
              Untitled.leave()
            }
        },
      ),
    );
  }
}
