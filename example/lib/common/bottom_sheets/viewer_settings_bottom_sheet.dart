import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmssdk_flutter_example/common/app_dialogs/hls_aspect_ratio_option_dialog.dart';
import 'package:hmssdk_flutter_example/common/util/app_color.dart';
import 'package:hmssdk_flutter_example/common/util/utility_components.dart';
import 'package:hmssdk_flutter_example/common/bottom_sheets/participants_bottom_sheet.dart';
import 'package:hmssdk_flutter_example/meeting/meeting_store.dart';
import 'package:provider/provider.dart';

class ViewerSettingsBottomSheet extends StatefulWidget {
  @override
  State<ViewerSettingsBottomSheet> createState() =>
      _ViewerSettingsBottomSheetState();
}

class _ViewerSettingsBottomSheetState extends State<ViewerSettingsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    MeetingStore _meetingStore = context.read<MeetingStore>();
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "More Options",
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            color: themeDefaultColor,
                            letterSpacing: 0.15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/close_button.svg",
                          width: 40,
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
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Divider(
                  color: dividerColor,
                  height: 5,
                ),
              ),
              ListTile(
                horizontalTitleGap: 2,
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  String name = await UtilityComponents.showNameChangeDialog(
                      context: context,
                      placeholder: "Enter Name",
                      prefilledValue:
                          context.read<MeetingStore>().localPeer?.name ?? "");
                  if (name.isNotEmpty) {
                    context.read<MeetingStore>().changeName(name: name);
                  }
                  Navigator.pop(context);
                },
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(
                  "assets/icons/pencil.svg",
                  fit: BoxFit.scaleDown,
                ),
                title: Text(
                  "Change Name",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      color: themeDefaultColor,
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                horizontalTitleGap: 2,
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: themeBottomSheetColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    context: context,
                    builder: (ctx) => ChangeNotifierProvider.value(
                        value: _meetingStore, child: ParticipantsBottomSheet()),
                  );
                },
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset(
                  "assets/icons/participants.svg",
                  fit: BoxFit.scaleDown,
                ),
                title: Text(
                  "Participants",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      color: themeDefaultColor,
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                  horizontalTitleGap: 2,
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (_) => AspectRatioOptionDialog(
                                availableAspectRatios: [
                                  "16:9",
                                  "4:3",
                                  "1:1",
                                  "3:4",
                                  "9:16"
                                ],
                                setAspectRatio: (double aspectRatio) {
                                  context
                                      .read<MeetingStore>()
                                      .setPIPVideoController(true,
                                          aspectRatio: aspectRatio);
                                  Navigator.pop(context);
                                }));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    "assets/icons/aspect_ratio.svg",
                    fit: BoxFit.scaleDown,
                    color: themeDefaultColor,
                  ),
                  title: Text(
                    "Set Aspect Ratio",
                    semanticsLabel: "fl_aspect_ratio",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: themeDefaultColor,
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.w600),
                  )),
              ListTile(
                  horizontalTitleGap: 2,
                  onTap: () async {
                    context
                        .read<MeetingStore>()
                        .hlsVideoController
                        ?.enablePictureInPicture(
                            context.read<MeetingStore>().pipFlutterPlayerKey);
                    Navigator.pop(context);
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    "assets/icons/screen_share.svg",
                    fit: BoxFit.scaleDown,
                    color: themeDefaultColor,
                  ),
                  title: Text(
                    "Enter Pip Mode",
                    semanticsLabel: "fl_pip_mode",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: themeDefaultColor,
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}