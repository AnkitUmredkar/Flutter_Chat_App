import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<VideoCallScreen> {
  String userId = DateTime.now().millisecondsSinceEpoch.toString();
  String userName = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 994286960,
      appSign: '4018cb3b38c277bdab9d1defd67277dcd67268ba7d9797f54833ca4ace60c1b4',
      userID: userId,
      userName: userName,
      callID: 'demo_call_id_for_testing',
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
