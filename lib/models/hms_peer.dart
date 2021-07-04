class HMSPeer {
  bool isLocal;
  String peerId;
  String name;
  String customerId;
  String customerDescription;
  String role;
  //List<HMSTrack> auxilaryTrack;
  //HMSVideoTrack videoTrack;
  //HMSAudioTrack audioTrack;



  HMSPeer({required this.isLocal,required this.peerId,required this.name,required this.customerId,
     required this.customerDescription,required this.role});
}
