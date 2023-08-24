import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hms_room_kit/src/layout_api/hms_theme_colors.dart';
import 'package:hms_room_kit/src/widgets/bottom_sheets/stop_recording_bottom_sheet.dart';
import 'package:hms_room_kit/src/widgets/common_widgets/more_option_item.dart';
import 'package:hms_room_kit/src/common/constants.dart';
import 'package:hms_room_kit/src/widgets/bottom_sheets/participants_bottom_sheet.dart';
import 'package:hms_room_kit/src/widgets/common_widgets/hms_title_text.dart';
import 'package:hms_room_kit/src/meeting/meeting_store.dart';
import 'package:provider/provider.dart';

class AppUtilitiesBottomSheet extends StatefulWidget {
  const AppUtilitiesBottomSheet({Key? key}) : super(key: key);
  @override
  State<AppUtilitiesBottomSheet> createState() =>
      _AppUtilitiesBottomSheetState();
}

class _AppUtilitiesBottomSheetState extends State<AppUtilitiesBottomSheet> {
  @override
  Widget build(BuildContext context) {
    MeetingStore meetingStore = context.read<MeetingStore>();
    return FractionallySizedBox(
      heightFactor: 0.4,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      HMSTitleText(
                        text: "Options",
                        textColor: HMSThemeColors.onSurfaceHighEmphasis,
                        letterSpacing: 0.15,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: HMSThemeColors.onSurfaceHighEmphasis,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Divider(
                  color: HMSThemeColors.borderDefault,
                  height: 5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MoreOptionItem(
                      onTap: () async {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: HMSThemeColors.surfaceDim,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          context: context,
                          builder: (ctx) => ChangeNotifierProvider.value(
                              value: context.read<MeetingStore>(),
                              child: const ParticipantsBottomSheet()),
                        );
                      },
                      optionIcon: badge.Badge(
                        badgeStyle: badge.BadgeStyle(
                            badgeColor: HMSThemeColors.surfaceDefault,
                            padding: EdgeInsets.all(
                                context.read<MeetingStore>().peers.length < 1000
                                    ? 5
                                    : 8)),
                        badgeContent: HMSTitleText(
                          text: context
                              .read<MeetingStore>()
                              .peers
                              .length
                              .toString(),
                          textColor: HMSThemeColors.onSurfaceHighEmphasis,
                          fontSize: 10,
                          lineHeight: 16,
                          letterSpacing: 1.5,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  (context.read<MeetingStore>().peers.length <
                                          1000
                                      ? 5
                                      : 10)),
                          child: SvgPicture.asset(
                            "packages/hms_room_kit/lib/src/assets/icons/participants.svg",
                            height: 20,
                            width: 20,
                            colorFilter: ColorFilter.mode(
                                HMSThemeColors.onSurfaceHighEmphasis,
                                BlendMode.srcIn),
                          ),
                        ),
                      ),
                      optionText: "Participants"),
                  const SizedBox(
                    width: 12,
                  ),
                  MoreOptionItem(
                    onTap: () async {
                      Navigator.pop(context);
                      if (meetingStore.isScreenShareOn) {
                        meetingStore.stopScreenShare();
                      } else {
                        meetingStore.startScreenShare();
                      }
                    },
                    isActive: meetingStore.isScreenShareOn,
                    optionIcon: SvgPicture.asset(
                      "packages/hms_room_kit/lib/src/assets/icons/screen_share.svg",
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                          HMSThemeColors.onSurfaceHighEmphasis,
                          BlendMode.srcIn),
                    ),
                    optionText: meetingStore.isScreenShareOn
                        ? "Sharing Screen"
                        : "Share Screen",
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  MoreOptionItem(
                      onTap: () async {
                        meetingStore.changeMetadataBRB();
                        Navigator.pop(context);
                      },
                      isActive: meetingStore.isBRB,
                      optionIcon: SvgPicture.asset(
                        "packages/hms_room_kit/lib/src/assets/icons/brb.svg",
                        colorFilter: ColorFilter.mode(
                            HMSThemeColors.onSurfaceHighEmphasis,
                            BlendMode.srcIn),
                      ),
                      optionText:
                          meetingStore.isBRB ? "I'm Back" : "Be Right Back")
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MoreOptionItem(
                      onTap: () async {
                        context.read<MeetingStore>().changeMetadata();
                        Navigator.pop(context);
                      },
                      isActive: meetingStore.isRaisedHand,
                      optionIcon: SvgPicture.asset(
                        "packages/hms_room_kit/lib/src/assets/icons/hand_outline.svg",
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            HMSThemeColors.onSurfaceHighEmphasis,
                            BlendMode.srcIn),
                      ),
                      optionText: meetingStore.isRaisedHand
                          ? "Lower Hand"
                          : "Raise Hand"),
                  const SizedBox(
                    width: 12,
                  ),
                  if (meetingStore
                          .localPeer?.role.permissions.browserRecording ??
                      false)
                    MoreOptionItem(
                      onTap: () async {
                        bool isRecordingRunning = ((meetingStore
                                    .recordingType["hls"] ??
                                false) ||
                            (meetingStore.recordingType["browser"] ?? false) ||
                            (meetingStore.recordingType["server"] ?? false));
                        if (isRecordingRunning) {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: HMSThemeColors.surfaceDim,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16)),
                            ),
                            context: context,
                            builder: (ctx) => StopRecordingBottomSheet(
                              meetingStore: meetingStore,
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                          meetingStore.startRtmpOrRecording(
                              meetingUrl: Constant.streamingUrl,
                              toRecord: true,
                              rtmpUrls: null);
                        }
                      },
                      isActive: ((meetingStore.recordingType["hls"] ?? false) ||
                          (meetingStore.recordingType["browser"] ?? false) ||
                          (meetingStore.recordingType["server"] ?? false)),
                      optionIcon: SvgPicture.asset(
                        "packages/hms_room_kit/lib/src/assets/icons/record.svg",
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            HMSThemeColors.onSurfaceHighEmphasis,
                            BlendMode.srcIn),
                      ),
                      optionText: ((meetingStore.recordingType["hls"] ??
                                  false) ||
                              (meetingStore.recordingType["browser"] ??
                                  false) ||
                              (meetingStore.recordingType["server"] ?? false))
                          ? "Stop Recording"
                          : "Start Recording",
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}