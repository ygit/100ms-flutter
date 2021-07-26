package live.hms.hmssdk_flutter

import live.hms.video.sdk.models.HMSRoom

class HMSRoomExtension {
    companion object{
        fun toDictionary(room:HMSRoom?):HashMap<String,Any>?{
            val hashMap=HashMap<String,Any>()

            if (room==null)return null
            hashMap.put("id",room.roomId )
            hashMap.put("name",room.name )
            hashMap.put("hms_local_peer", HMSPeerExtension.toDictionary(room.localPeer)!!)
            val args=ArrayList<Any>()
            room.peerList.map {
                args.add(HMSPeerExtension.toDictionary(it)!!)
            }
            hashMap.put("peers",args)
            return hashMap
        }
    }
}