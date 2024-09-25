import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter/widgets.dart';
//
// class ChatOneScreen extends StatelessWidget {
//   ChatOneScreen({Key? key})
//       : super(
//           key: key,
//         );
//
//   TextEditingController messageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         centerTitle: true,
//         title: ListTile(
//           title: Text(
//             "Abdul Rahman",
//             style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold
//             ),
//           ),
//           leading: CircleAvatar(
//             backgroundColor: Colors.grey.shade400,
//             radius: 18,
//             backgroundImage: NetworkImage(
//                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSQKaS7LP80SEcKgz9-d_ORjkh1B9hPSUqkeI_mLSnDg&s"
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.symmetric(
//             horizontal: 24.h,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 12.v),
//                     Text(
//                       "Today, Feb 10, 2021",
//                       style: CustomTextStyles.labelLargeBluegray300,
//                     ),
//                     SizedBox(height: 20.v),
//                     Container(
//                       width: 268.h,
//                       margin: EdgeInsets.only(left: 74.h),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 1.h,
//                         vertical: 12.v,
//                       ),
//                       decoration: AppDecoration.fillGray10001.copyWith(
//                         borderRadius: BorderRadiusStyle.customBorderTL101,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(height: 2.v),
//                           Container(
//                             width: 250.h,
//                             margin: EdgeInsets.only(left: 16.h),
//                             child: Text(
//                               "Good day!\nI need help with my test results",
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: CustomTextStyles.titleMediumBlack900SemiBold
//                                   .copyWith(
//                                 height: 1.33,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 12.v),
//                     _buildIconStatusReaded(
//                       context,
//                       time: "10:24 AM",
//                     ),
//                     SizedBox(height: 11.v),
//                     Container(
//                       margin: EdgeInsets.only(left: 74.h),
//                       decoration: AppDecoration.fillGray10001.copyWith(
//                         borderRadius: BorderRadiusStyle.customBorderTL101,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 14.v),
//                           Padding(
//                             padding: EdgeInsets.only(left: 17.h),
//                             child: Text(
//                               "Here it is",
//                               style: CustomTextStyles.titleMediumBlack900SemiBold,
//                             ),
//                           ),
//                           SizedBox(height: 12.v),
//                           CustomImageView(
//                             imagePath: ImageConstant.imgImg,
//                             height: 160.v,
//                             width: 268.h,
//                             radius: BorderRadius.only(
//                               bottomLeft: Radius.circular(10.h),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 12.v),
//                     _buildIconStatusReaded(
//                       context,
//                       time: "10:25 AM",
//                     ),
//                     SizedBox(height: 13.v),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 52.h),
//                         child: Row(
//                           children: [
//                             CustomImageView(
//                               imagePath: ImageConstant.imgContrast40x40,
//                               height: 40.adaptSize,
//                               width: 40.adaptSize,
//                               margin: EdgeInsets.only(
//                                 top: 38.v,
//                                 bottom: 32.v,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 14.h),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.all(12.h),
//                                     decoration: AppDecoration.fillPrimary.copyWith(
//                                       borderRadius:
//                                       BorderRadiusStyle.customBorderTL101,
//                                     ),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         SizedBox(height: 2.v),
//                                         Container(
//                                           width: 207.h,
//                                           margin: EdgeInsets.only(left: 4.h),
//                                           child: Text(
//                                             "Hello, John!\nJust give me 5 min, please",
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: CustomTextStyles
//                                                 .titleMediumOnErrorContainerSemiBold
//                                                 .copyWith(
//                                               height: 1.33,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 12.v),
//                                   Text(
//                                     "10:27 AM",
//                                     style: CustomTextStyles.bodyMediumBluegray300,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                   margin: EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 20
//                   ),
//                   child: _buildMessage(context)
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// Section Widget
//   Widget _buildMessage(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Expanded(
//           child: CustomTextFormField(
//             controller: messageController,
//             hintText: "Type your message here",
//             hintStyle: CustomTextStyles.bodyLargeBluegray300,
//             textInputAction: TextInputAction.done,
//             suffix: Container(
//               margin: EdgeInsets.fromLTRB(30.h, 11.v, 10.h, 11.v),
//               child: CustomImageView(
//                 color: Colors.grey,
//                 imagePath: ImageConstant.imgButtonattachfile,
//                 height: 22.adaptSize,
//                 width: 22.adaptSize,
//               ),
//             ),
//             suffixConstraints: BoxConstraints(
//               maxHeight: 44.v,
//             ),
//             contentPadding: EdgeInsets.only(
//               left: 11.h,
//               top: 9.v,
//               bottom: 9.v,
//             ),
//             borderDecoration: TextFormFieldStyleHelper.fillGray,
//             filled: true,
//             fillColor: appTheme.gray10001,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 14.h),
//           child: CustomIconButton(
//             height: 44.adaptSize,
//             width: 44.adaptSize,
//             padding: EdgeInsets.all(11.h),
//             decoration: IconButtonStyleHelper.outlineBlueGrayTL10,
//             child: CustomImageView(
//               color: Colors.white,
//               imagePath: ImageConstant.imgButtonSend,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   /// Common widget
//   Widget _buildIconStatusReaded(
//     BuildContext context, {
//     required String time,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         CustomImageView(
//           imagePath: ImageConstant.imgIconStatusReaded,
//           height: 16.adaptSize,
//           width: 16.adaptSize,
//           margin: EdgeInsets.only(
//             top: 1.v,
//             bottom: 2.v,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 6.h),
//           child: Text(
//             time,
//             style: CustomTextStyles.bodyMediumBluegray300.copyWith(
//               color: appTheme.blueGray300,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_basic_chat_bubble/flutter_basic_chat_bubble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatOneScreen extends StatefulWidget {
  ChatOneScreen();

  @override
  State<ChatOneScreen> createState() => _ChatOneScreenState();
}

class _ChatOneScreenState extends State<ChatOneScreen> {
  TextEditingController massageText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            title: Text(
              "Abdul Rahman",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              radius: 18,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSQKaS7LP80SEcKgz9-d_ORjkh1B9hPSUqkeI_mLSnDg&s"),
            ),
          ),
        ),
        body: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return BasicChatBubble(
                    message: index % 2 == 0
                        ? BasicChatMessage(
                            messageText: "✓✓ 8:30 pm",
                            peerUserName: "",
                            timeStamp: "Hello How are You Bro",
                          )
                        : BasicChatMessage(
                            messageText: "✓✓ 8:30 pm",
                            peerUserName: "I am Fine",
                            timeStamp: "",
                          ),
                    isMe: index % 2 == 0,
                    backgroundColor: (index % 2 == 0
                        ? Color(0xffF3F7F9)
                        : const Color(0xff0066FF)),
                    textColor: (index % 2 == 0
                        ? const Color(0xff141414)
                        : Colors.white),
                  );
                },
                itemCount: 4,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: massageText,
                            decoration: InputDecoration(
                              hintText: "Type your message here",
                              hintStyle: TextStyle(
                                color: Color(0xff8EA0AB),
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              focusColor: Colors.grey.shade500,
                              contentPadding: EdgeInsets.only(
                                left: 11.h,
                                top: 9.v,
                                bottom: 9.v,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  // Handle the icon press here
                                  print("Icon pressed!");
                                },
                                child: Icon(Icons.attachment_rounded,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        // FloatingActionButton(
                        //     onPressed: (){
                        //
                        //     },
                        //   shape: CircleBorder(),
                        //   elevation: 8,
                        //   child: ,
                        //   backgroundColor: Color(0xff0066FF),
                        // )
                        Padding(
                          padding: EdgeInsets.only(left: 14.h),
                          child: CustomIconButton(
                            height: 50.adaptSize,
                            width: 50.adaptSize,
                            padding: EdgeInsets.all(11.h),
                            decoration:
                                IconButtonStyleHelper.outlineBlueGrayTL10,
                            child: CustomImageView(
                              color: Colors.white,
                              imagePath: ImageConstant.imgButtonSend,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
