import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:hmssdk_flutter/models/hms_config.dart';


class MeetLogIn extends StatefulWidget {
  const MeetLogIn() : super();

  @override
  _MeetLogInState createState() => _MeetLogInState();
}

class _MeetLogInState extends State<MeetLogIn> {
  late TextEditingController nameController,meetingFieldController;
  late HMSConfig _hmsConfig;
  late String meetingId;

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

  void initializeTextEditingControllers(){
    nameController=new TextEditingController();
    meetingFieldController=new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white12,
        leading: Icon(Icons.list, color: Colors.blue, size: 40.0,),
        actions: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.settings, color: Colors.blue, size: 40.0,),
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
                  Icon(Icons.video_call, size: 40.0, color: Colors.blue,),
                  Icon(Icons.mic, size: 40.0, color: Colors.blue,)
                ],
              ),
              SizedBox(height: 50.0,),
              Text("Join a Meeting",
                style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),),
              SizedBox(height: 15.0,),
              TextField(
                controller: meetingFieldController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "Enter Meeting ID"),
              ),
              FlatButton(onPressed: () {
                popUp(context).then((value) => {
                  if(value!=null){
                    meetingId=meetingFieldController.text.toString(),
                    if(meetingFieldController.text.isNotEmpty){

                      _hmsConfig=new HMSConfig(userId: value, roomId: meetingId, authToken: "authToken"),
                      //HmssdkFlutter.joinMeet(_hmsConfig)
                    }
                    //Untitled.joinMeet(value, "key")

                  }
                });
              }, child:
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.video_call,color: Colors.white,),
                    Text("Join Meeting",style: TextStyle(color: Colors.white,fontSize: 15.0),)
                  ],
                ),
              ),
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
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
}