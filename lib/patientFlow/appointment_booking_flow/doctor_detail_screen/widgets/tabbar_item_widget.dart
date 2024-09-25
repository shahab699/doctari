// import 'package:doctari/widgets/custom_icon_button.dart';
// import 'package:flutter/material.dart';
// import 'package:doctari/core/app_export.dart';

// // ignore: must_be_immutable
// class TabbarItemWidget extends StatelessWidget {
//   int index;
//   int score;

//   TabbarItemWidget({Key? key, required this.index, required this.score})
//       : super(
//           key: key,
//         );

//   List<String> iconsList = [
//     'assets/images/img_close_primary.svg',
//     'assets/myassets/medal.svg',
//     'assets/myassets/star.svg',
//     'assets/myassets/messages.svg',
//   ];

//   List<String> textType = ['patient', 'experience', 'rating', 'reviews'];

//   List<String> numberOfExperience = [
//     '2,000+',
//     '10+',
//     '5',
//     '1,872',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 56.h,
//       child: Column(
//         children: [
//           CustomIconButton(
//             height: 56.adaptSize,
//             width: 56.adaptSize,
//             padding: EdgeInsets.all(12.h),
//             child: CustomImageView(
//               imagePath: iconsList[index],
//               color: Color(0xff0066FF),
//             ),
//           ),
//           SizedBox(height: 2.v),
//           Text(
//             numberOfExperience[index],
//             overflow: TextOverflow.ellipsis,
//             softWrap: true,
//             style: CustomTextStyles.titleSmallBluegray700_1,
//           ),
//           SizedBox(height: 3.v),
//           Text(
//             textType[index],
//             overflow: TextOverflow.ellipsis,
//             softWrap: true,
//             style: CustomTextStyles.titleSmallMedium,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabbarItemWidget extends StatefulWidget {
  final int index;
  final double score;

  TabbarItemWidget({Key? key, required this.index, required this.score})
      : super(key: key);

  @override
  State<TabbarItemWidget> createState() => _TabbarItemWidgetState();
}

class _TabbarItemWidgetState extends State<TabbarItemWidget> {
  late List<String> numberOfExperience;

  List<String> iconsList = [
    'assets/images/img_close_primary.svg',
    'assets/myassets/medal.svg',
    'assets/myassets/star.svg',
    'assets/myassets/messages.svg',
  ];

  List<String> textType = ['patient', 'experience', 'rating', 'reviews'];

  @override
  void initState() {
    super.initState();
    numberOfExperience = [
      '2,000+',
      '10+',
      '${widget.score.toInt()}',
      '1,872',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.h,
      child: Column(
        children: [
          CustomIconButton(
            height: 55.adaptSize,
            width: 56.adaptSize,
            padding: EdgeInsets.all(12.h),
            child: CustomImageView(
              imagePath: iconsList[widget.index],
              color: Color(0xff0066FF),
            ),
          ),
          SizedBox(height: 2.v),
          Text(
            numberOfExperience[widget.index],
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: CustomTextStyles.titleSmallBluegray700_1,
          ),
          SizedBox(height: 3.v),
          Text(
            textType[widget.index],
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: CustomTextStyles.titleSmallMedium,
          ),
        ],
      ),
    );
  }
}
