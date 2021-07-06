import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:hmssdk_flutter_example/common/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hmssdk_flutter/models/hms_config.dart';
import 'package:permission_handler/permission_handler.dart';

class MeetLogIn extends StatefulWidget {
  const MeetLogIn() : super();

  @override
  _MeetLogInState createState() => _MeetLogInState();
}

class _MeetLogInState extends State<MeetLogIn> {
  late TextEditingController nameController, meetingFieldController;
  late HMSConfig _hmsConfig;
  late String meetingId;
  late HmssdkFlutter _hmssdkFlutter;

  Future<dynamic> popUp(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Enter Your Name"),
              content: TextField(
                controller: textEditingController,
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx)
                          .pop(textEditingController.text.toString());
                    },
                    child: Text("Join"))
              ],
            ));
  }

  void initializeTextEditingControllers() {
    _hmssdkFlutter = HmssdkFlutter();
    nameController = new TextEditingController();
    meetingFieldController = new TextEditingController();
  }

  @override
  void initState() {
    // TODO: implement initState
    initializeTextEditingControllers();
    takePermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white12,
        leading: Icon(
          Icons.list,
          color: Colors.blue,
          size: 40.0,
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.settings,
              color: Colors.blue,
              size: 40.0,
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          height: 300.0,
          width: 200.0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      _hmssdkFlutter.leaveMeeting();
                    },
                    child: Icon(
                      Icons.video_call,
                      size: 40.0,
                      color: Colors.blue,
                    ),
                  ),
                  Icon(
                    Icons.mic,
                    size: 40.0,
                    color: Colors.blue,
                  )
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Join a Meeting",
                style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: meetingFieldController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "Enter Meeting ID"),
              ),
              FlatButton(
                onPressed: () {
                  popUp(context).then((userNameValue) => {
                        if (userNameValue != null)
                          {
                            meetingId = meetingFieldController.text.toString(),
                            if (meetingFieldController.text.isNotEmpty)
                              {
                                //HmssdkFlutter.joinMeet(_hmsConfig)
                                getToken(
                                    user: userNameValue,
                                    room: Constant.defaultRoomID),
                                debugPrint(meetingId)
                              }
                            //Untitled.joinMeet(value, "key")
                          }
                      });
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.video_call,
                        color: Colors.white,
                      ),
                      Text(
                        "Join Meeting",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      )
                    ],
                  ),
                ),
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    meetingFieldController.dispose();
    super.dispose();
  }

  Future<Void?> getToken({required String user, required String room}) async {
    debugPrint("hello");
    http.Response response = await http.post(Uri.parse(Constant.getTokenURL),
        body: {'room_id': room, 'user_id': user, 'role': 'host'});
    debugPrint(response.body);
    var body = json.decode(response.body);
    _hmsConfig = new HMSConfig(
      userName: user,
      authToken: body['token'],
      roomId: meetingId,
    );
    _hmssdkFlutter.joinMeeting1(_hmsConfig);
  }

  Future<Void?> takePermissions() async{
    var status = await Permission.camera.status;
    await Permission.camera.request();
  }
}
