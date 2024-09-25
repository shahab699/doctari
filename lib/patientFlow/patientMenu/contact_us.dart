import 'package:doctari/widgets/app_bar/custom_app_bar.dart';
import 'package:doctari/widgets/app_bar/appbar_leading_image.dart';
import 'package:doctari/widgets/app_bar/appbar_subtitle_nine.dart';
import 'package:doctari/widgets/custom_text_form_field.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
   ContactUsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  // TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   final String _emailAddress = 'support@doctari.com';

   Future<void> _launchEmailApp(BuildContext context) async {
     String email = titleController.text.trim();
     String message = messageController.text.trim();

     String subject = email;
     String body =
         message;

     final String encodedSubject = Uri.encodeComponent(subject);
     final String encodedBody = Uri.encodeComponent(body);

     final String emailUri =
         'mailto:$_emailAddress?subject=$encodedSubject&body=$encodedBody';

     try {
       final Uri uri = Uri.parse(emailUri);

       if (await canLaunchUrl(uri)) {
         await launchUrl(uri);
       } else {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Text(
               "Could not launch the email application.",
             ),
             duration: Duration(seconds: 3),
           ),
         );
       }
     } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text(
             "Error launching email application: $e",
           ),
           duration: Duration(seconds: 3),
         ),
       );
     }
   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${AppLocalizations.of(context)!.contactUsDoctorMenuScreenSC}",
            style: CustomTextStyles.titleLargeBluegray800.copyWith(
              color: appTheme.blueGray800,
            ),
          ),
        ),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 27.h,
                  vertical: 28.v,
                ),
                child: Column(
                  children: [
                    // _buildName(context),
                    SizedBox(height: 15.v),
                    _buildTitle(context),
                    SizedBox(height: 16.v),
                    _buildMessage(context),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildSubmit(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDownBlueGray800,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 16.v,
          bottom: 15.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitleNine(
        text: "${AppLocalizations.of(context)!.contactUsDoctorMenuScreenSC}",
      ),
    );
  }

  /// Section Widget
  // Widget _buildName(BuildContext context) {
  //   return CustomTextFormField(
  //     controller: nameController,
  //     hintText:
  //         "${AppLocalizations.of(context)!.nameDashboardAfterBookingScrnSC} ",
  //     contentPadding: EdgeInsets.symmetric(
  //       horizontal: 16.h,
  //       vertical: 12.v,
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildTitle(BuildContext context) {
    return CustomTextFormField(
      controller: titleController,
      hintText: "${AppLocalizations.of(context)!.title}",
      textInputType: TextInputType.emailAddress,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildMessage(BuildContext context) {
    return CustomTextFormField(
      controller: messageController,
      hintText: "${AppLocalizations.of(context)!.writeMessageContactUsSC}",
      textInputAction: TextInputAction.done,
      maxLines: 8,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildSubmit(BuildContext context) {
    return CustomElevatedButton(
      onPressed: (){
        _launchEmailApp(context);
      },
      text: "${AppLocalizations.of(context)!.submitContactUsSC}",
      margin: EdgeInsets.only(
        left: 27.h,
        right: 27.h,
        bottom: 28.v,
      ),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer_2,
    );
  }

   @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    messageController.dispose();
  }
}


