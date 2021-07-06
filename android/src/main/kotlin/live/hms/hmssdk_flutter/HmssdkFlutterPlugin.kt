package live.hms.hmssdk_flutter

import android.app.Activity
import androidx.annotation.NonNull
import io.flutter.Log
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
class HmssdkFlutterPlugin: FlutterPlugin, MethodCallHandler,ActivityAware  {
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

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
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

  fun hmsListener():HMSUpdateListener{
    return object: HMSUpdateListener{

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
  }


  fun joinMeeting(@NonNull call: MethodCall){
    val userName=call.argument<String>("userName")
    val authToken= call.argument<String>("authToken")
    val shouldSkipPiiEvents=call.argument<Boolean>("shouldSkipPiiEvents")
    Log.i("userName",authToken!!)
    val hmsConfig=HMSConfig(userName = userName!!,authtoken = authToken!!)
 //   val hmssdk1=HMSSDK.Builder(activity).shouldSkipPIIEvents(shouldSkipPiiEvents!!).build()
    val hmsUpdateListener=hmsListener()
    hmssdk.join(hmsConfig,hmsUpdateListener)
  }

  fun leaveMeeting(){
    if (hmssdk!=null)
      hmssdk.leave()
    else
      Log.e("error","not initialized")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {

    activity=binding.activity
    hmssdk=HMSSDK.Builder(activity).build()
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity=binding.activity
  }

  override fun onDetachedFromActivity() {

  }



}
