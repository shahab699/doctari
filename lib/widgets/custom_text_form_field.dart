import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  final Alignment? alignment;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextStyle? textStyle;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool filled;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: textFormFieldWidget(),
          )
        : textFormFieldWidget();
  }

  Widget textFormFieldWidget() {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        style: widget.textStyle,
        obscureText: widget.obscureText,
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
          hintText: widget.hintText ?? "",
          hintStyle: widget.hintStyle,
          prefixIcon: widget.prefix,
          prefixIconConstraints: widget.prefixConstraints,
          suffixIcon: widget.suffix,
          suffixIconConstraints: widget.suffixConstraints,
          isDense: true,
          contentPadding: widget.contentPadding ??
              EdgeInsets.only(
                left: 16.h,
                top: 16.v,
                bottom: 16.v,
              ),
          fillColor: widget.fillColor,
          filled: widget.filled,
          border: _getBorder(),
          enabledBorder: _getBorder(),
          focusedBorder: _getFocusedBorder(),
        ),
        validator: (value) {
          String? validationMessage = widget.validator?.call(value);
          setState(() {
            hasError = validationMessage != null;
          });
          return validationMessage;
        },
        onChanged: (value) {
          setState(() {
            hasError = widget.validator?.call(value) != null;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );
  }

  InputBorder _getBorder() {
    return hasError
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          )
        : widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.h),
              borderSide: BorderSide(
                color: appTheme.gray50001,
                width: 1,
              ),
            );
  }

  InputBorder _getFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.h),
      borderSide: BorderSide(
        color: appTheme.blueGray500.withOpacity(0.16),
        width: 1,
      ),
    );
  }
}
/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineGrayTL12 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.h),
        borderSide: BorderSide(
          color: appTheme.gray50001,
          width: 1,
        ),
      );
  static OutlineInputBorder get fillGray => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get outlineBlack => OutlineInputBorder(
        borderRadius: BorderRadius.circular(27.h),
        borderSide: BorderSide.none,
      );
}


// import 'package:flutter/material.dart';
// import '../core/app_export.dart';

// class CustomTextFormField extends StatelessWidget {
//   CustomTextFormField({
//     Key? key,
//     this.alignment,
//     this.width,
//     this.scrollPadding,
//     this.controller,
//     this.focusNode,
//     this.autofocus = false,
//     this.textStyle,
//     this.obscureText = false,
//     this.textInputAction = TextInputAction.next,
//     this.textInputType = TextInputType.text,
//     this.maxLines,
//     this.hintText,
//     this.hintStyle,
//     this.prefix,
//     this.prefixConstraints,
//     this.suffix,
//     this.suffixConstraints,
//     this.contentPadding,
//     this.borderDecoration,
//     this.fillColor,
//     this.filled = false,
//     this.validator,
//   }) : super(
//           key: key,
//         );

//   final Alignment? alignment;
//   final double? width;
//   final EdgeInsets? scrollPadding;  // Corrected type to EdgeInsets
//   final TextEditingController? controller;
//   final FocusNode? focusNode;
//   final bool? autofocus;
//   final TextStyle? textStyle;
//   final bool? obscureText;
//   final TextInputAction? textInputAction;
//   final TextInputType? textInputType;
//   final int? maxLines;
//   final String? hintText;
//   final TextStyle? hintStyle;
//   final Widget? prefix;
//   final BoxConstraints? prefixConstraints;
//   final Widget? suffix;
//   final BoxConstraints? suffixConstraints;
//   final EdgeInsets? contentPadding;
//   final InputBorder? borderDecoration;
//   final Color? fillColor;
//   final bool? filled;
//   final FormFieldValidator<String>? validator;

//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//             alignment: alignment ?? Alignment.center,
//             child: textFormFieldWidget(context),
//           )
//         : textFormFieldWidget(context);
//   }

//   Widget textFormFieldWidget(BuildContext context) => SizedBox(
//         width: width ?? double.maxFinite,
//         child: TextFormField(
//           scrollPadding: scrollPadding ??
//               EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           controller: controller,
//           focusNode: focusNode ?? FocusNode(),
//           autofocus: autofocus ?? false,
//           style: textStyle ?? Theme.of(context).textTheme.bodyLarge,
//           obscureText: obscureText ?? false,
//           textInputAction: textInputAction,
//           keyboardType: textInputType,
//           maxLines: maxLines ?? 1,
//           decoration: decoration,
//           validator: validator,
//         ),
//       );

//   InputDecoration get decoration => InputDecoration(
//         hintText: hintText ?? "",
//         hintStyle: hintStyle ?? TextStyle(color: Colors.grey),
//         prefixIcon: prefix,
//         prefixIconConstraints: prefixConstraints,
//         suffixIcon: suffix,
//         suffixIconConstraints: suffixConstraints,
//         isDense: true,
//         contentPadding: contentPadding ??
//             EdgeInsets.only(
//               left: 16.0,
//               top: 16.0,
//               bottom: 16.0,
//             ),
//         fillColor: fillColor,
//         filled: filled,
//         border: borderDecoration ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(4.0),
//               borderSide: BorderSide(
//                 color: Colors.grey.shade500,
//                 width: 1,
//               ),
//             ),
//         enabledBorder: borderDecoration ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(4.0),
//               borderSide: BorderSide(
//                 color: Colors.grey.shade500,
//                 width: 1,
//               ),
//             ),
//         focusedBorder: borderDecoration ??
//             OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.0),
//               borderSide: BorderSide(
//                 color: Colors.blueGrey.withOpacity(0.16),
//                 width: 1,
//               ),
//             ),
//       );
// }

// extension TextFormFieldStyleHelper on CustomTextFormField {
//   static OutlineInputBorder get outlineGrayTL12 => OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.0),
//         borderSide: BorderSide(
//           color: Colors.grey.shade500,
//           width: 1,
//         ),
//       );
//   static OutlineInputBorder get fillGray => OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10.0),
//         borderSide: BorderSide.none,
//       );
//   static OutlineInputBorder get outlineBlack => OutlineInputBorder(
//         borderRadius: BorderRadius.circular(27.0),
//         borderSide: BorderSide.none,
//       );
// }