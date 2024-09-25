import 'package:doctari/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTrailingIconbutton extends StatelessWidget {
  AppbarTrailingIconbutton({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 30.adaptSize,
          width: 30.adaptSize,
          decoration: IconButtonStyleHelper.fillRedA,
          child: CustomImageView(
            imagePath: ImageConstant.imgClose,
          ),
        ),
      ),
    );
  }
}
