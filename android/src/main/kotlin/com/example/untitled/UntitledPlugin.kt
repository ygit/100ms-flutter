package com.example.untitled

import android.app.Activity
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import live.hms.video.error.HMSException
import live.hms.video.media.tracks.HMSTrack
import live.hms.video.sdk.HMSSDK
import live.hms.video.sdk.HMSUpdateListener
import live.hms.video.sdk.models.HMSConfig
import live.hms.video.sdk.models.HMSMessage
import live.hms.video.sdk.models.HMSPeer
import live.hms.video.sdk.models.HMSRoom
import live.hms.video.sdk.models.enums.HMSPeerUpdate
import live.hms.video.sdk.models.enums.HMSRoomUpdate
import live.hms.video.sdk.models.enums.HMSTrackUpdate



/** UntitledPlugin */
class UntitledPlugin: FlutterPlugin, MethodCallHandler,ActivityAware {

  private lateinit var channel : MethodChannel
  private var application : Activity ?=null
  private lateinit var hmsSdk:HMSSDK
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "untitled")
    channel.setMethodCallHandler(this)

  }

  fun joinMeet(username:String,authToken: String){
    val config=HMSConfig(username,authToken)
    val hmsUpdateListener = object: HMSUpdateListener {

      override fun onJoin(room: HMSRoom) {
        // This will be called on a successful JOIN of the room by the user
        // This is the point where applications can stop showing its loading state
      }

      override fun onPeerUpdate(type: HMSPeerUpdate, peer: HMSPeer) {
        // This will be called whenever there is an update on an existing peer
        // or a new peer got added/existing peer is removed.
        // This callback can be used to keep a track of all the peers in the room
      }

      override fun onRoomUpdate(type: HMSRoomUpdate, hmsRoom: HMSRoom) {
        // This is called when there is a change in any property of the Room
      }

      override fun onTrackUpdate(type: HMSTrackUpdate, track: HMSTrack, peer: HMSPeer) {
        // This is called when there are updates on an existing track
        // or a new track got added/existing track is removed
        // This callback can be used to render the video on screen whenever a track gets added
      }

      override fun onMessageReceived(message: HMSMessage) {
        // This is called when there is a new broadcast message from any other peer in the room
        // This can be used to implement chat is the room
      }

      override fun onError(error: HMSException) {
        // This will be called when there is an error in the system
        // and SDK has already retried to fix the error
      }

      override fun onReconnecting(error: HMSException) {
        // This is called when connection reestablishment starts
        // This can be used to show a loading notification in the UI
        // Parameter error: the error from the action that failed and caused the connection reestablishment
      }

      override fun onReconnected() {
        // This is called when the connection reestablishment completed susccessfully
      }

    }
    hmsSdk.join(config, hmsUpdateListener)
  }

  fun leave(){
    hmsSdk.leave()
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }
    else if(call.method == "joinMeet"){
      val username:String=call.argument<String>("userName").toString()
      val authID:String=call.argument<String>("tokenID").toString()
      joinMeet(username = username,authToken = authID)
    }
    else if(call.method == "leave"){
      leave()
    }
    else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)

  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    application=binding.activity
    hmsSdk=HMSSDK.Builder(application!!).build()
  }

  override fun onDetachedFromActivityForConfigChanges() {
    application=null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    application=binding.activity
  }

  override fun onDetachedFromActivity() {
    application=null
  }

}
