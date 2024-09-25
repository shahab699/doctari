import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

Widget customAvatarBuilder(
  BuildContext context,
  Size size,
  ZegoUIKitUser? user,
  Map<String, dynamic> extraInfo,
) {
  return Container(
    width: size.width,
    height: size.height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey, // Set a default color for the avatar
    ),
    child: Center(
      child: Text(
        // Display the first letter of the user's name as the avatar
        user?.name != null && user!.name.isNotEmpty
            ? user.name[0].toUpperCase()
            : '?',
        style: TextStyle(
          color: Colors.white, // Set the text color
          fontSize: size.height * 0.5, // Adjust the font size
          fontWeight: FontWeight.bold, // Optionally set the font weight
        ),
      ),
    ),
  );
}
