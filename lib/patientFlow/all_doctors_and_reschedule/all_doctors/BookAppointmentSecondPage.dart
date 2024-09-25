import 'dart:convert';
import 'package:doctari/core/app_export.dart';
import 'package:doctari/Provider/user_id_provider.dart';
import 'package:doctari/patientAPI/patient_apis_service.dart';
import 'package:doctari/payement_methode/payement_methode.dart';
import 'package:doctari/sessionManager/session_manager.dart';
import 'package:doctari/theme/custom_button_style.dart';
import 'package:doctari/theme/custom_text_style.dart';
import 'package:doctari/web%20view/payement_webview.dart';
import 'package:doctari/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class BookAppointmentSecondPage extends StatefulWidget {
  final String dateAndTime;
  final String appointmentReason;
  final int doctorId;
  const BookAppointmentSecondPage({
    required this.dateAndTime,
    required this.appointmentReason,
    required this.doctorId,
  });
  @override
  _BookAppointmentSecondPageState createState() =>
      _BookAppointmentSecondPageState();
}

class _BookAppointmentSecondPageState extends State<BookAppointmentSecondPage> {
  List<Map<String, dynamic>> selectedDiseases = [];
  List<Map<String, dynamic>> selectedMedications = [];
  List<Map<String, dynamic>> selectedAllergies = [];
  bool isLoadingButton = false;

  Future<List<Map<String, dynamic>>> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(
          data.map((item) => {"id": item['id'], "name": item['name']}));
      return dataList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _selectItems(List<Map<String, dynamic>> selectedItems,
      String title, String url) async {
    List<Map<String, dynamic>> fetchedItems = await fetchData(url);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        List<bool> checkedList = List.generate(
            fetchedItems.length,
            (index) => selectedItems
                .any((item) => item['id'] == fetchedItems[index]['id']));

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: List.generate(fetchedItems.length, (index) {
                    return CheckboxListTile(
                      title: Text(fetchedItems[index]['name']),
                      value: checkedList[index],
                      onChanged: (bool? value) {
                        setState(() {
                          checkedList[index] = value!;
                          if (value) {
                            if (!selectedItems.any((item) =>
                                item['id'] == fetchedItems[index]['id'])) {
                              selectedItems.add(fetchedItems[index]);
                            }
                          } else {
                            selectedItems.removeWhere((selectedItem) =>
                                selectedItem['id'] ==
                                fetchedItems[index]['id']);
                          }
                        });
                      },
                    );
                  }),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '${AppLocalizations.of(context)!.closeBookAppointmentSecondPageSC}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? userId = SessionManager.getUserId();
    String? userToken = SessionManager.getUserToken();
    print("idd: ${int.parse(userId!)}");
    // int? patientId = Provider.of<ProviderForStoringValues>(context).patientId;
    // String? patientAccessToken =
    //     Provider.of<ProviderForStoringValues>(context).accessToken;
    debugPrint("id of the patient: ${userId}");
    debugPrint("patientAccessToken is: $userToken");

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   leading: BackButton(
      //     color: Colors.white,

      //   ),
      //   centerTitle: true,
      //   backgroundColor: theme.colorScheme.primary,
      //   title: Text(
      //       '${AppLocalizations.of(context)!.bookAppointmentAllDoctorsPageSC}'),
      //   titleTextStyle: TextStyle(color: Colors.white),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
            '${AppLocalizations.of(context)!.bookAppointmentAllDoctorsPageSC}'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              '${AppLocalizations.of(context)!.selectDiseasesBookAppointmentSecondPageSC}:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   selectedDiseases.isEmpty
            //       ? 'Tap to select diseases'
            //       : selectedDiseases.map((item) => item['name']).join(', '),
            //   style: TextStyle(fontSize: 14, color: Colors.black),
            // ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedDiseases
                  .map(
                    (item) => Chip(
                      backgroundColor: Colors.blue[300],
                      label: Text(
                        item['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onDeleted: () {
                        setState(() {
                          selectedDiseases.remove(item);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            ListTile(
              title: Text(
                '${AppLocalizations.of(context)!.selectDiseasesBookAppointmentSecondPageSC}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.local_hospital,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () async {
                await _selectItems(selectedDiseases, 'Diseases',
                    'https://api-b2c-refactor.doctari.com/diseases/');
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            Text(
              '${AppLocalizations.of(context)!.selectedMedicationsBookAppointmentSecondPageSC}:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Text(selectedMedications.isEmpty
            //     ? 'Tap to select medications'
            //     : selectedMedications.map((item) => item['name']).join(', ')),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedMedications
                  .map(
                    (item) => Chip(
                      backgroundColor: Colors.blue[300],
                      label: Text(
                        item['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onDeleted: () {
                        setState(() {
                          selectedMedications.remove(item);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            ListTile(
              title: Text(
                '${AppLocalizations.of(context)!.selectedMedicationsBookAppointmentSecondPageSC}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.local_pharmacy,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () async {
                await _selectItems(selectedMedications, 'Medications',
                    'https://api-b2c-refactor.doctari.com/medications/');
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            Text(
              '${AppLocalizations.of(context)!.selecAllergiesBookAppointmentSecondPageSC}:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Text(selectedAllergies.isEmpty
            //     ? 'Tap to select allergies'
            //     : selectedAllergies.map((item) => item['name']).join(', ')),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedAllergies
                  .map(
                    (item) => Chip(
                      backgroundColor: Colors.blue[300],
                      label: Text(
                        item['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onDeleted: () {
                        setState(() {
                          selectedAllergies.remove(item);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            ListTile(
              title: Text(
                '${AppLocalizations.of(context)!.selecAllergiesBookAppointmentSecondPageSC}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.warning,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () async {
                await _selectItems(selectedAllergies, 'Allergies',
                    'https://api-b2c-refactor.doctari.com/allergies/');
                setState(() {});
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          _buildConfirm(context, int.parse(userId), userToken!),
    );
  }

  Widget _buildConfirm(BuildContext context, int patientId, String token) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: isLoadingButton
          ? Center(child: CircularProgressIndicator())
          : CustomElevatedButton(
              // height: 54.v,
              text:
                  "${AppLocalizations.of(context)!.confirmBookAppointmentSecondPageSC}",
              onPressed: () async {
                setState(() {
                  isLoadingButton = true;
                  print("True Here");
                });
                // Parse time string into DateTime object
                print(
                    " disease: ${selectedDiseases.map((item) => item['id'].toString()).toList()}");
                await PatientApiService().createAppointment(
                    context,
                    widget.dateAndTime,
                    widget.doctorId,
                    patientId,
                    widget.appointmentReason,
                    selectedDiseases
                        .map((item) => item['id'].toString())
                        .toList(), // Convert IDs to strings
                    selectedMedications
                        .map((item) => item['id'].toString())
                        .toList(), // Convert IDs to strings
                    selectedAllergies
                        .map((item) => item['id'].toString())
                        .toList(),
                    token);

                // createPreference();

                setState(() {
                  isLoadingButton = false;
                  print("False Here");
                });
              },
              margin: EdgeInsets.only(
                // left: 24.h,
                // right: 24.h,
                bottom: 10.v,
              ),
              buttonStyle: CustomButtonStyles.fillPrimary,
              buttonTextStyle:
                  CustomTextStyles.titleMediumOnErrorContainerSemiBold18,
            ),
    );
  }

  //create prefrences here

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
// Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => WebViewPageView(urlLink: sandboxInitPoint,)));
        print('Sandbox Init Point URL:\n$sandboxInitPoint');
      } else {
        print('Failed to create preference: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
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
