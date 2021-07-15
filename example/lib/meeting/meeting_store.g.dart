// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeetingStore on MeetingStoreBase, Store {
  final _$isSpeakerOnAtom = Atom(name: 'MeetingStoreBase.isSpeakerOn');

  @override
  bool get isSpeakerOn {
    _$isSpeakerOnAtom.reportRead();
    return super.isSpeakerOn;
  }

  @override
  set isSpeakerOn(bool value) {
    _$isSpeakerOnAtom.reportWrite(value, super.isSpeakerOn, () {
      super.isSpeakerOn = value;
    });
  }

  final _$isMeetingStartedAtom =
      Atom(name: 'MeetingStoreBase.isMeetingStarted');

  @override
  bool get isMeetingStarted {
    _$isMeetingStartedAtom.reportRead();
    return super.isMeetingStarted;
  }

  @override
  set isMeetingStarted(bool value) {
    _$isMeetingStartedAtom.reportWrite(value, super.isMeetingStarted, () {
      super.isMeetingStarted = value;
    });
  }

  final _$isVideoOnAtom = Atom(name: 'MeetingStoreBase.isVideoOn');

  @override
  bool get isVideoOn {
    _$isVideoOnAtom.reportRead();
    return super.isVideoOn;
  }

  @override
  set isVideoOn(bool value) {
    _$isVideoOnAtom.reportWrite(value, super.isVideoOn, () {
      super.isVideoOn = value;
    });
  }

  final _$isMicOnAtom = Atom(name: 'MeetingStoreBase.isMicOn');

  @override
  bool get isMicOn {
    _$isMicOnAtom.reportRead();
    return super.isMicOn;
  }

  @override
  set isMicOn(bool value) {
    _$isMicOnAtom.reportWrite(value, super.isMicOn, () {
      super.isMicOn = value;
    });
  }

  final _$startMeetingAsyncAction =
      AsyncAction('MeetingStoreBase.startMeeting');

  @override
  Future<void> startMeeting() {
    return _$startMeetingAsyncAction.run(() => super.startMeeting());
  }

  final _$MeetingStoreBaseActionController =
      ActionController(name: 'MeetingStoreBase');

  @override
  void toggleSpeaker() {
    final _$actionInfo = _$MeetingStoreBaseActionController.startAction(
        name: 'MeetingStoreBase.toggleSpeaker');
    try {
      return super.toggleSpeaker();
    } finally {
      _$MeetingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleVideo() {
    final _$actionInfo = _$MeetingStoreBaseActionController.startAction(
        name: 'MeetingStoreBase.toggleVideo');
    try {
      return super.toggleVideo();
    } finally {
      _$MeetingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAudio() {
    final _$actionInfo = _$MeetingStoreBaseActionController.startAction(
        name: 'MeetingStoreBase.toggleAudio');
    try {
      return super.toggleAudio();
    } finally {
      _$MeetingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSpeakerOn: ${isSpeakerOn},
isMeetingStarted: ${isMeetingStarted},
isVideoOn: ${isVideoOn},
isMicOn: ${isMicOn}
    ''';
  }
}
