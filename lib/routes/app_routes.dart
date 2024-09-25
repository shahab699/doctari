// import 'package:flutter/material.dart';
// import '../patientFlow/doctor_detail_screen/doctor_details_screen.dart';
// import '../patientFlow/registration_screens/login_screen/login_screen.dart';
// import '../patientFlow/registration_screens/sign_up_as_doctor_screen/sign_up_as_doctor_screen.dart';
// import '../patientFlow/registration_screens/sign_up_screen_2_for_patient_screen/sign_up_screen_2_for_patient_screen.dart';
// import '../patientFlow/registration_screens/sign_up_screen_docotor_screen/sign_up_screen_docotor_screen.dart';
// import '../patientFlow/registration_screens/sign_up_screen_one_for_patient_screen/sign_up_screen_one_for_patient_screen.dart';
// import '../patientFlow/registration_screens/sign_up_screen_three_screen/sign_up_screen_three_screen.dart';
// import '../presentation/forgot_password_screen/forgot_password_screen.dart';
// import '../presentation/forgot_password_three_screen/forgot_password_three_screen.dart';
// import '../presentation/forgot_password_two_screen/forgot_password_two_screen.dart';
// import '../presentation/menu_screen/menu_screen.dart';
// import '../presentation/onboarding_screens/onboarding_screen_one_screen/onboarding_screen_one_screen.dart';
// import '../presentation/onboarding_screens/onboarding_screen_three_screen/onboarding_screen_three_screen.dart';
// import '../presentation/onboarding_screens/onboarding_screen_two_screen/onboarding_screen_two_screen.dart';
// import '../presentation/onboarding_screens/register_as_screen/register_as_screen.dart';
// import '../presentation/onboarding_screens/splash_screen/splash_screen.dart';
// import '../presentation/patient_login_screen/patient_login_screen.dart';
// import '../presentation/profile_screen_one_screen/profile_screen_one_screen.dart';
// import '../presentation/settings_screen_one_screen/settings_screen_one_screen.dart';
// import '../presentation/settings_screen/settings_screen.dart';
// import '../presentation/notification_screen/notification_screen.dart';
// import '../presentation/contact_us_screen/contact_us_screen.dart';
// import '../presentation/logout_screen/logout_screen.dart';
// import '../presentation/menu_screen_one_screen/menu_screen_one_screen.dart';
// import '../presentation/profile_screen/profile_screen.dart';

// import '../presentation/patient_dashboard_screen/patient_dashboard_screen.dart';
// import '../presentation/patient_dashboard_two_screen/patient_dashboard_two_screen.dart';
// import '../presentation/dashboard_one_screen/dashboard_one_screen.dart';
// import '../presentation/after_booking_dashboard_one_screen/after_booking_dashboard_one_screen.dart';
// import '../presentation/after_booking_dashboard_screen/after_booking_dashboard_screen.dart';
// import '../presentation/dashboard_three_screen/dashboard_three_screen.dart';
// import '../presentation/select_time_and_appointment_type_screen/select_time_and_appointment_type_screen.dart';
// import '../presentation/payment_screen/payment_screen.dart';
// import '../presentation/after_booking_dash_screen/after_booking_dash_screen.dart';
// import '../presentation/appointment_details_one_screen/appointment_details_one_screen.dart';
// import '../presentation/select_date_hour_screen/select_date_hour_screen.dart';
// import '../presentation/appointment_details_two_screen/appointment_details_two_screen.dart';
// import '../presentation/live_chat_one_screen/live_chat_one_screen.dart';
// import '../presentation/video_call_screen/video_call_screen.dart';
// import '../presentation/chatbox_screen/chatbox_screen.dart';
// import '../presentation/chat_screen/chat_screen.dart';
// import '../presentation/upcoming_appointments_tab_container_screen/upcoming_appointments_tab_container_screen.dart';
// import '../presentation/appointment_details_three_screen/appointment_details_three_screen.dart';
// import '../presentation/reschedule_screen/reschedule_screen.dart';
// import '../presentation/appointment_details_screen/appointment_details_screen.dart';
// import '../presentation/live_chat_screen/live_chat_screen.dart';
// import '../presentation/video_call_three_screen/video_call_three_screen.dart';
// import '../presentation/review_and_rating_one_screen/review_and_rating_one_screen.dart';
// import '../presentation/chatbox_one_screen/chatbox_one_screen.dart';
// import '../presentation/chat_one_screen/chat_one_screen.dart';
// import '../presentation/all_doctors_tab_container_screen/all_doctors_tab_container_screen.dart';
// import '../presentation/reschedule_one_screen/reschedule_one_screen.dart';
// import '../presentation/app_navigation_screen/app_navigation_screen.dart';

// class AppRoutes {
//   static const String menuScreen = '/menu_screen';

//   static const String profileScreenOneScreen = '/profile_screen_one_screen';

//   static const String settingsScreenOneScreen = '/settings_screen_one_screen';

//   static const String settingsScreen = '/settings_screen';

//   static const String notificationScreen = '/notification_screen';

//   static const String contactUsScreen = '/contact_us_screen';

//   static const String logoutScreen = '/logout_screen';

//   static const String menuScreenOneScreen = '/menu_screen_one_screen';

//   static const String profileScreen = '/profile_screen';

//   static const String splashScreen = '/splash_screen';

//   static const String onboardingScreenOneScreen =
//       '/onboarding_screen_one_screen';

//   static const String onboardingScreenTwoScreen =
//       '/onboarding_screen_two_screen';

//   static const String onboardingScreenThreeScreen =
//       '/onboarding_screen_three_screen';

//   static const String registerAsScreen = '/register_as_screen';

//   static const String signUpScreenOneForPatientScreen =
//       '/sign_up_screen_one_for_patient_screen';

//   static const String signUpScreen2ForPatientScreen =
//       '/sign_up_screen_2_for_patient_screen';

//   static const String patientLoginScreen = '/patient_login_screen';

//   static const String forgotPasswordScreen = '/forgot_password_screen';

//   static const String forgotPasswordTwoScreen = '/forgot_password_two_screen';

//   static const String forgotPasswordThreeScreen =
//       '/forgot_password_three_screen';

//   static const String signUpAsDoctorScreen = '/sign_up_as_doctor_screen';

//   static const String signUpScreenDocotorScreen =
//       '/sign_up_screen_docotor_screen';

//   static const String signUpScreenThreeScreen = '/sign_up_screen_three_screen';

//   static const String loginScreen = '/login_screen';

//   static const String patientDashboardScreen = '/patient_dashboard_screen';

//   static const String patientDashboardTwoScreen =
//       '/patient_dashboard_two_screen';

//   static const String dashboardOneScreen = '/dashboard_one_screen';

//   static const String afterBookingDashboardOneScreen =
//       '/after_booking_dashboard_one_screen';

//   static const String afterBookingDashboardScreen =
//       '/after_booking_dashboard_screen';

//   static const String dashboardThreeScreen = '/dashboard_three_screen';

//   static const String doctorDetailsScreen = '/doctor_details_screen';

//   static const String selectTimeAndAppointmentTypeScreen =
//       '/select_time_and_appointment_type_screen';

//   static const String paymentScreen = '/payment_screen';

//   static const String afterBookingDashScreen = '/after_booking_dash_screen';

//   static const String appointmentDetailsOneScreen =
//       '/appointment_details_one_screen';

//   static const String selectDateHourScreen = '/select_date_hour_screen';

//   static const String appointmentDetailsTwoScreen =
//       '/appointment_details_two_screen';

//   static const String liveChatOneScreen = '/live_chat_one_screen';

//   static const String videoCallScreen = '/video_call_screen';

//   static const String chatboxScreen = '/chatbox_screen';

//   static const String chatScreen = '/chat_screen';

//   static const String upcomingAppointmentsPage = '/upcoming_appointments_page';

//   static const String upcomingAppointmentsTabContainerScreen =
//       '/upcoming_appointments_tab_container_screen';

//   static const String appointmentDetailsThreeScreen =
//       '/appointment_details_three_screen';

//   static const String rescheduleScreen = '/reschedule_screen';

//   static const String completedAppointmentsPage =
//       '/completed_appointments_page';

//   static const String appointmentDetailsScreen = '/appointment_details_screen';

//   static const String liveChatScreen = '/live_chat_screen';

//   static const String videoCallThreeScreen = '/video_call_three_screen';

//   static const String reviewAndRatingOneScreen =
//       '/review_and_rating_one_screen';

//   static const String chatboxOneScreen = '/chatbox_one_screen';

//   static const String chatOneScreen = '/chat_one_screen';

//   static const String allDoctorsPage = '/all_doctors_page';

//   static const String allDoctorsTabContainerScreen =
//       '/all_doctors_tab_container_screen';

//   static const String upcomingAppointmentsOnePage =
//       '/upcoming_appointments_one_page';

//   static const String rescheduleOneScreen = '/reschedule_one_screen';

//   static const String completedAppointmentsOnePage =
//       '/completed_appointments_one_page';

//   static const String appNavigationScreen = '/app_navigation_screen';

//   static Map<String, WidgetBuilder> routes = {
//     menuScreen: (context) => MenuScreen(),
//     profileScreenOneScreen: (context) => ProfileScreenOneScreen(),
//     settingsScreenOneScreen: (context) => SettingsScreenOneScreen(),
//     settingsScreen: (context) => SettingsScreen(),
//     notificationScreen: (context) => NotificationScreen(),
//     contactUsScreen: (context) => ContactUsScreen(),
//     logoutScreen: (context) => LogoutScreen(),
//     menuScreenOneScreen: (context) => MenuScreenOneScreen(),
//     profileScreen: (context) => ProfileScreen(),
//     splashScreen: (context) => SplashScreen(),
//     onboardingScreenOneScreen: (context) => OnboardingScreenOneScreen(),
//     onboardingScreenTwoScreen: (context) => OnboardingScreenTwoScreen(),
//     onboardingScreenThreeScreen: (context) => OnboardingScreenThreeScreen(),
//     registerAsScreen: (context) => RegisterAsScreen(),
//     signUpScreenOneForPatientScreen: (context) =>
//         SignUpScreenOneForPatientScreen(),
//     signUpScreen2ForPatientScreen: (context) => SignUpScreen2ForPatientScreen(),
//     patientLoginScreen: (context) => PatientLoginScreen(),
//     forgotPasswordScreen: (context) => ForgotPasswordScreen(),
//     forgotPasswordTwoScreen: (context) => ForgotPasswordTwoScreen(),
//     forgotPasswordThreeScreen: (context) => ForgotPasswordThreeScreen(),
//     signUpAsDoctorScreen: (context) => SignUpAsDoctorScreen(),
//     signUpScreenDocotorScreen: (context) => SignUpScreenDocotorScreen(),
//     signUpScreenThreeScreen: (context) => SignUpScreenThreeScreen(),
//     loginScreen: (context) => LoginScreen(),
//     patientDashboardScreen: (context) => PatientDashboardScreen(),
//     patientDashboardTwoScreen: (context) => PatientDashboardTwoScreen(),
//     dashboardOneScreen: (context) => DashboardOneScreen(),
//     afterBookingDashboardOneScreen: (context) =>
//         AfterBookingDashboardOneScreen(),
//     afterBookingDashboardScreen: (context) => AfterBookingDashboardScreen(),
//     dashboardThreeScreen: (context) => DashboardThreeScreen(),
//     doctorDetailsScreen: (context) => DoctorDetailsScreen(),
//     selectTimeAndAppointmentTypeScreen: (context) =>
//         SelectTimeAndAppointmentTypeScreen(),
//     paymentScreen: (context) => PaymentScreen(),
//     afterBookingDashScreen: (context) => AfterBookingDashScreen(),
//     appointmentDetailsOneScreen: (context) => AppointmentDetailsOneScreen(),
//     selectDateHourScreen: (context) => SelectDateHourScreen(),
//     appointmentDetailsTwoScreen: (context) => AppointmentDetailsTwoScreen(),
//     liveChatOneScreen: (context) => LiveChatOneScreen(),
//     videoCallScreen: (context) => VideoCallScreen(),
//     chatboxScreen: (context) => ChatboxScreen(),
//     chatScreen: (context) => ChatScreen(),
//     upcomingAppointmentsTabContainerScreen: (context) =>
//         UpcomingAppointmentsTabContainerScreen(),
//     appointmentDetailsThreeScreen: (context) => AppointmentDetailsThreeScreen(),
//     rescheduleScreen: (context) => RescheduleScreen(),
//     appointmentDetailsScreen: (context) => AppointmentDetailsScreen(),
//     liveChatScreen: (context) => LiveChatScreen(),
//     videoCallThreeScreen: (context) => VideoCallThreeScreen(),
//     reviewAndRatingOneScreen: (context) => ReviewAndRatingOneScreen(),
//     chatboxOneScreen: (context) => ChatboxOneScreen(),
//     chatOneScreen: (context) => ChatOneScreen(),
//     allDoctorsTabContainerScreen: (context) => AllDoctorsTabContainerScreen(),
//     rescheduleOneScreen: (context) => RescheduleOneScreen(),
//     appNavigationScreen: (context) => AppNavigationScreen()
//   };
// }
