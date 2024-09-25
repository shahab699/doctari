import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmationCard extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final Map<String, dynamic> productDetails;

  const ConfirmationCard(
      {Key? key,
      required this.onAccept,
      required this.onReject,
      required this.productDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.confirmationConfirmationCardSC}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("AppointmentType",
                      '${productDetails['appointmentType']}'),
                  _buildDivider(),
                  _buildDetailRow("Date", '${productDetails['date']}'),
                  _buildDivider(),
                  _buildDetailRow("Time", '${productDetails['time']}'),
                ],
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: onAccept,
                    child: Text(
                      '${AppLocalizations.of(context)!.acceptConfirmationCardSC}',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onReject,
                    child: Text(
                      '${AppLocalizations.of(context)!.rejectConfirmationCardSC}',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      height: 16.0,
      thickness: 1.0,
    );
  }
}


// import 'package:flutter/material.dart';

// class ConfirmationCard extends StatelessWidget {
//   final VoidCallback onAccept;
//   final VoidCallback onReject;
//   final Map<String, dynamic> productDetails;

//   const ConfirmationCard(
//       {Key? key,
//       required this.onAccept,
//       required this.onReject,
//       required this.productDetails})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Appointment Confirmation',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 15),
//             Text(
//               'Please accept to confirm appointment. THANKS!',
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: onAccept,
//                   child: Text(
//                     'Accept',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.black,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: onReject,
//                   child: Text(
//                     'Reject',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.white,
//                     side: BorderSide(color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
