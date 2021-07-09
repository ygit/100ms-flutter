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
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
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
import kotlin.coroutines.CoroutineContext


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
        Log.i("OnJoin","HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHEEEEEEEEEEEEEEEEEE"+room.name)
        val args=HashMap<String,Any>()
        args.put("name",room.name)
        args.put("roomId",room.roomId)
        room.localPeer
        //args.put("roomLocalPeer",room.localPeer)
        Log.i("OnJoin",args.get("roomId").toString())
        CoroutineScope(Dispatchers.Main).launch {
          channel.invokeMethod("onJoinAndroid",args)
        }

      }

      override fun onPeerUpdate(type: HMSPeerUpdate, peer: HMSPeer) {
        Log.i("onPeerUpdate","HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHEEEEEEEEEEEEEEEEEE")

      }

      override fun onRoomUpdate(type: HMSRoomUpdate, hmsRoom: HMSRoom) {
        Log.i("onRoomUpdate","HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHEEEEEEEEEEEEEEEEEE")
      }

      override fun onTrackUpdate(type: HMSTrackUpdate, track: HMSTrack, peer: HMSPeer) {
        Log.i("onTrackUpdate","HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHEEEEEEEEEEEEEEEEEE")
      }

      override fun onMessageReceived(message: HMSMessage) {
        Log.i("onMessageReceived","HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHEEEEEEEEEEEEEEEEEE")
      }

      override fun onError(error: HMSException) {
        Log.i("onError","HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHEEEEEEEEEEEEEEEEEE")
        val args=HashMap<String,Any>()
        args.put("action",error.action)
        args.put("description",error.description)
        args.put("name",error.name)
        args.put("code",error.code.toString())
        CoroutineScope(Dispatchers.Main).launch {
          channel.invokeMethod("onErrorAndroid",args)
        }

      }

      override fun onReconnecting(error: HMSException) {
        Log.i("onReconnecting","HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHEEEEEEEEEEEEEEEEEE")
        val args=HashMap<String,Any>()
        args.put("action",error.action)
        args.put("description",error.description)
        args.put("name",error.name)
        args.put("code",error.code.toString())
        args.put("message",error.message)
        CoroutineScope(Dispatchers.Main).launch {
          channel.invokeMethod("onReconnectingAndroid",args)
        }

      }

      override fun onReconnected() {
        Log.i("onReconnected","HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHEEEEEEEEEEEEEEEEEE")
        CoroutineScope(Dispatchers.Main).launch {
          channel.invokeMethod("onReconnectedAndroid",null)
        }

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
