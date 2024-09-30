import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class MeetingService {
  Future<void> joinMeeting(String room, String displayName, String email) async {
    try{
      var jitsiMeet = JitsiMeet();

      var options = JitsiMeetConferenceOptions(
        room: room,
        configOverrides: {
          "startWithAudioMuted": true,
          "startWithVideoMuted": false,
          "subject": "Demo Video",
        },
        featureFlags: {
          FeatureFlags.addPeopleEnabled: true,
          FeatureFlags.welcomePageEnabled: false,
          FeatureFlags.preJoinPageEnabled: false,
          FeatureFlags.unsafeRoomWarningEnabled: true,
          FeatureFlags.resolution: FeatureFlagVideoResolutions.resolution720p,
          FeatureFlags.audioFocusDisabled: true,
          FeatureFlags.audioMuteButtonEnabled: true,
          FeatureFlags.audioOnlyButtonEnabled: true,
          FeatureFlags.calenderEnabled: true,
          FeatureFlags.callIntegrationEnabled: true,
          FeatureFlags.carModeEnabled: true,
          FeatureFlags.closeCaptionsEnabled: true,
          FeatureFlags.conferenceTimerEnabled: true,
          FeatureFlags.chatEnabled: true,
          FeatureFlags.filmstripEnabled: true,
          FeatureFlags.fullScreenEnabled: true,
          FeatureFlags.helpButtonEnabled: true,
          FeatureFlags.inviteEnabled: true,
          FeatureFlags.androidScreenSharingEnabled: true,
          FeatureFlags.speakerStatsEnabled: true,
          FeatureFlags.kickOutEnabled: true,
          FeatureFlags.liveStreamingEnabled: true,
          FeatureFlags.lobbyModeEnabled: true,
          FeatureFlags.meetingNameEnabled: true,
          FeatureFlags.meetingPasswordEnabled: true,
          FeatureFlags.notificationEnabled: true,
          FeatureFlags.overflowMenuEnabled: true,
          FeatureFlags.pipEnabled: true,
          FeatureFlags.pipWhileScreenSharingEnabled: true,
          FeatureFlags.preJoinPageHideDisplayName: true,
          FeatureFlags.raiseHandEnabled: true,
          FeatureFlags.reactionsEnabled: true,
          FeatureFlags.recordingEnabled: true,
          FeatureFlags.replaceParticipant: true,
          FeatureFlags.securityOptionEnabled: true,
          FeatureFlags.serverUrlChangeEnabled: true,
          FeatureFlags.settingsEnabled: true,
          FeatureFlags.tileViewEnabled: true,
          FeatureFlags.videoMuteEnabled: true,
          FeatureFlags.videoShareEnabled: true,
          FeatureFlags.toolboxEnabled: true,
          FeatureFlags.iosRecordingEnabled: false,
          FeatureFlags.iosScreenSharingEnabled: false,
          FeatureFlags.toolboxAlwaysVisible: true,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: displayName,
          email: email,
        ),
      );

      await jitsiMeet.join(options);

    }
    catch(error){
      debugPrint('Failed to join Jitsi Meet Room: $error');
    }

  }
}
