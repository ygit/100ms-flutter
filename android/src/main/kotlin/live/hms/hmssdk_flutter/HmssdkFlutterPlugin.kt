package live.hms.hmssdk_flutter

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
import java.util.*
//import java.util.*
//import java.util.*
import kotlin.collections.*


/** HmssdkFlutterPlugin */
class HmssdkFlutterPlugin: FlutterPlugin, MethodCallHandler, HMSUpdateListener,ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity

  private lateinit var channel : MethodChannel
  private lateinit var activity:Activity
  private lateinit var hmssdk: HMSSDK
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "hmssdk_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }
    else if(call.method == "joinMeeting"){
      joinMeeting(call)
    }
    else if (call.method =="leaveMeeting"){
      leaveMeeting()
    }
    else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onError(error: HMSException) {
    TODO("Not yet implemented")
  }

  override fun onJoin(room: HMSRoom) {
    TODO("Not yet implemented")
  }

  override fun onMessageReceived(message: HMSMessage) {
    TODO("Not yet implemented")
  }

  override fun onPeerUpdate(type: HMSPeerUpdate, peer: HMSPeer) {
    TODO("Not yet implemented")
  }

  override fun onRoomUpdate(type: HMSRoomUpdate, hmsRoom: HMSRoom) {
    TODO("Not yet implemented")
  }

  override fun onTrackUpdate(type: HMSTrackUpdate, track: HMSTrack, peer: HMSPeer) {
    TODO("Not yet implemented")
  }


  fun joinMeeting(call: MethodCall){
    val userName=call.argument<String>("userName")
    val authToken= call.argument<String>("authToken")
    val shouldSkipPiiEvents=call.argument<Boolean>("shouldSkipPiiEvents")
    val hmsConfig=HMSConfig(userName = userName!!,authtoken = authToken!!)
    hmssdk=HMSSDK.Builder(activity).shouldSkipPIIEvents(shouldSkipPiiEvents!!).build()
    hmssdk.join(hmsConfig,this)
  }

  fun leaveMeeting(){
    hmssdk.leave()
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {

    activity=binding.activity

  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity=binding.activity
  }

  override fun onDetachedFromActivity() {

  }
}
