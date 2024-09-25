import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      print('Sandbox Init Point URL:\n$sandboxInitPoint');
    } else {
      print('Failed to create preference: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception occurred: $e');
  }
}

// Future<Map<String, dynamic>> createPreference() async {
//   final String url = 'https://api.mercadopago.com/checkout/preferences';
//   final String accessToken =
//       'TEST-5331374759545786-082910-fc4e2ee25d27e7f9a18c99c911c11506__LC_LA__-259028468';
//   final Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $accessToken',
//   };

//   final Map<String, dynamic> body = {
//     // Add your request body parameters here
//     // Example:
//     "external_reference": "ABC",
//     "items": [
//       {
//         "title": "products",
//         "description": "item",
//         "quantity": 1,
//         "unit_price": 10
//       }
//     ]
//   };

//   try {
//     // debugger();

//     final response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: jsonEncode(body),
//     );

//     if (response.statusCode == 201) {
//       print("response ${response[]['sandbox_init_point']}");
//       // Successfully created preference
//       return jsonDecode(response.body);
//     } else {
//       // Handle error
//       throw Exception('Failed to create preference: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Handle exception
//     throw Exception('Exception occurred: $e');
//   }
// }



// 
//void checkOut() async {
//   try {
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization':
//           'Bearer TEST-5331374759545786-082910-fc4e2ee25d27e7f9a18c99c911c11506__LC_LA__-259028468'
//     };
//     var request = http.Request(
//         'POST',
//         Uri.parse(
//             'https://api.mercadopago.com/checkout/preferences?access_token=TEST-5331374759545786-082910-fc4e2ee25d27e7f9a18c99c911c11506__LC_LA__-259028468'));
//     request.body = json.encode({
//       "external_reference": "ABC",
//       "items": [
//         {
//           "title": "products",
//           "description": "item",
//           "quantity": 1,
//           "unit_price": 10
//         }
//       ]
//     });
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();
//     print("response: $response");
//     print("client id: ${response['client_id']}");
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   } catch (e) {
//     print(e);
//   }
// }
