import 'package:doctari/ChatScreen/ChatScreen.dart';
import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_seven.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

class ChatboxOneScreen extends StatelessWidget {
  const ChatboxOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        surfaceTintColor: Colors.grey.shade100,
        title: AppbarSubtitleSeven(
          text: "Chats",
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
      ),
      body: Container(
        width: double.maxFinite,
        child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChatOneScreen();
                  },));
                },
                leading: CustomImageView(
                  imagePath: ImageConstant.imgContrast40x40,
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey,
                ),
                title: Text("Dr. Aaron", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),),
                subtitle: Text("Gynecologists", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),),
              );
            },
          itemCount: 20,
        )
      ),
    );
  }
}
