import 'dart:convert';
import 'package:doctari/core/app_export.dart';
import 'package:doctari/patientFlow/all_doctors_and_reschedule/all_doctors/BookAppointmentSecondPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentMethode extends StatefulWidget {
  final String dateAndTime;
  final String appointmentReason;
  final int doctorId;
  const PaymentMethode(
      {required this.dateAndTime,
      required this.appointmentReason,
      required this.doctorId,
      Key? key})
      : super(key: key);

  @override
  State<PaymentMethode> createState() => _PaymentMethodeState();
}

class _PaymentMethodeState extends State<PaymentMethode> {
  bool _isNextButtonEnabled = false; // Track if the button is enabled

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        title: Text(
          "${AppLocalizations.of(context)!.proceedPaymentdSC}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                child: Text(
                  'Click on card for payment',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: InkWell(
                onTap: () {
                  createPreference();
                  setState(() {
                    _isNextButtonEnabled = true; // Enable the Next button
                  });
                },
                child: Image.asset('assets/myassets/visa.png'),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.45,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: _isNextButtonEnabled // Check if the button is enabled
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookAppointmentSecondPage(
                              appointmentReason: widget.appointmentReason,
                              dateAndTime: widget.dateAndTime,
                              doctorId: widget.doctorId,
                            ),
                          ));
                    }
                  : null, // Disable the onTap action if button is not enabled
              child: Center(
                child: Container(
                  height: height * 0.06,
                  width: width * 0.7,
                  decoration: BoxDecoration(
                    color: _isNextButtonEnabled
                        ? theme.primaryColor
                        : Colors.grey, // Change color based on button state
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Future<void> createPreference() async {
    final String url = 'https://api.mercadopago.com/checkout/preferences';
    final String accessToken =
        'TEST-5331374759545786-082910-fc4e2ee25d27e7f9a18c99c911c11506__LC_LA__-259028468';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final Map<String, dynamic> body = {
      "items": [
        {
          "title": "products",
          "currency_id": "UYU",
          "description": "item",
          "quantity": 1,
          "unit_price": 10
        }
      ],
      "back_urls": {
        "success": "http://www.your-site.com/success",
        "failure": "http://www.your-site.com/failure",
        "pending": "http://www.your-site.com/pending"
      },
      "auto_return": "approved",
      "external_reference": "ABC",
      "payer": {"email": "payer@example.com"}
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final JsonEncoder encoder = JsonEncoder.withIndent('  ');
        final String prettyPrintResponse = encoder.convert(responseData);
        print('Response:\n$prettyPrintResponse');
        // To access and print the `sandbox_init_point` URL:
        final String sandboxInitPoint = responseData['sandbox_init_point'];
        _launchURL(sandboxInitPoint);
        print('Sandbox Init Point URL:\n$sandboxInitPoint');
      } else {
        print('Failed to create preference: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error, e.g., show an error message to the user
      print('Could not launch $url');
    }
  }
}
// import 'dart:convert';
// import 'package:doctari/core/app_export.dart';


// import 'package:doctari/patientFlow/all_doctors_and_reschedule/all_doctors/BookAppointmentSecondPage.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class PaymentMethode extends StatefulWidget {
//   final String dateAndTime;
//   final String appointmentReason;
//   final int doctorId;
//   const PaymentMethode(
//       {required this.dateAndTime,
//       required this.appointmentReason,
//       required this.doctorId,
//       Key? key})
//       : super(key: key);

//   @override
//   State<PaymentMethode> createState() => _PaymentMethodeState();
// }

// class _PaymentMethodeState extends State<PaymentMethode> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: BackButton(
//           color: Colors.white,
//         ),
//         centerTitle: true,
//         backgroundColor: theme.primaryColor,
//         title: Text(
//           "${AppLocalizations.of(context)!.proceedPaymentdSC}",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),
//       ),
//       body: SafeArea(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 25, right: 25),
//                 child: Text(
//                   'Click on card for payment',
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               )),
//           SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 25, right: 25),
//               child: InkWell(
//                 onTap: () {
//                   createPreference();
//                 },
//                 child: Image.asset('assets/myassets/visa.png'),
//                 // child: Container(
//                 //   height: 60,
//                 //   width: 170,
//                 //   decoration: BoxDecoration(
//                 //     color: theme.primaryColor,
//                 //     borderRadius: BorderRadius.circular(10),
//                 //   ),
//                 //   child: Center(
//                 //     child: Text(
//                 //       "${AppLocalizations.of(context)!.proceedPaymentdSC}",
//                 //       style: TextStyle(
//                 //         color: Colors.white,
//                 //         fontSize: 14,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 120,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BookAppointmentSecondPage(
//                       appointmentReason: widget.appointmentReason,
//                       dateAndTime: widget.dateAndTime,
//                       doctorId: widget.doctorId,
//                     ),
//                   ));
//             },
//             child: Center(
//               child: Container(
//                 height: 60,
//                 width: 170,
//                 decoration: BoxDecoration(
//                   color: theme.primaryColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Text(
//                     //"${AppLocalizations.of(context)!.proceedPaymentdSC}",\
//                     "Next",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       )),
//     );
//   }

//   Future<void> createPreference() async {
//     final String url = 'https://api.mercadopago.com/checkout/preferences';
//     final String accessToken =
//         'TEST-5331374759545786-082910-fc4e2ee25d27e7f9a18c99c911c11506__LC_LA__-259028468';

//     final Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $accessToken',
//     };

//     final Map<String, dynamic> body = {
//       "items": [
//         {
//           "title": "products",
//           "currency_id": "UYU",
//           "description": "item",
//           "quantity": 1,
//           "unit_price": 10
//         }
//       ],
//       "back_urls": {
//         "success": "http://www.your-site.com/success",
//         "failure": "http://www.your-site.com/failure",
//         "pending": "http://www.your-site.com/pending"
//       },
//       "auto_return": "approved",
//       "external_reference": "ABC",
//       "payer": {"email": "payer@example.com"}
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: headers,
//         body: jsonEncode(body),
//       );

//       if (response.statusCode == 201) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         final JsonEncoder encoder = JsonEncoder.withIndent('  ');
//         final String prettyPrintResponse = encoder.convert(responseData);
//         print('Response:\n$prettyPrintResponse');
//         // To access and print the `sandbox_init_point` URL:
//         final String sandboxInitPoint = responseData['sandbox_init_point'];
//         _launchURL(sandboxInitPoint);
// // Navigator.of(context).push(
// //                     MaterialPageRoute(builder: (context) => WebViewPageView(urlLink: sandboxInitPoint,)));
//         print('Sandbox Init Point URL:\n$sandboxInitPoint');
//       } else {
//         print('Failed to create preference: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Exception occurred: $e');
//     }
//   }

//   void _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       // Handle the error, e.g., show an error message to the user
//       print('Could not launch $url');
//     }
//   }
// }
