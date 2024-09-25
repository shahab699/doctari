// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:doctari/core/app_export.dart';

// class PaymentItemWidget extends StatefulWidget {
//   final String cardType;
//   final Function(bool)? onChanged;

//   const PaymentItemWidget({
//     Key? key,
//     required this.cardType,
//     this.onChanged,
//   }) : super(key: key);

//   @override
//   _PaymentItemWidgetState createState() => _PaymentItemWidgetState();
// }

// class _PaymentItemWidgetState extends State<PaymentItemWidget> {
//   bool _isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isSelected = true;
//           widget.onChanged?.call(true);
//         });
//       },
//       child: SizedBox(
//         width: 100.0,
//         child: Row(
//           children: [
//             Radio(
//               value: true,
//               groupValue: _isSelected,
//               onChanged: (bool? value) {
//                 setState(() {
//                   _isSelected = value!;
//                   widget.onChanged?.call(value);
//                 });
//               },
//             ),
//             SizedBox(width: 8.0), // Add spacing between radio button and SVG
//             Center(
//               child: SvgPicture.asset(
//                 'assets/myassets/${widget.cardType}.svg',
//                 width: 40.0,
//                 height: 20.0,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctari/core/app_export.dart';

class PaymentItemWidget extends StatelessWidget {
  final String cardType;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentItemWidget({
    Key? key,
    required this.cardType,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100.0,
        child: Row(
          children: [
            Radio(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
            ),
            SizedBox(width: 8.0), // Add spacing between radio button and SVG
            Center(
              child: SvgPicture.asset(
                'assets/myassets/$cardType.svg',
                width: 40.0,
                height: 20.0,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSelectionWidget extends StatefulWidget {
  @override
  _PaymentSelectionWidgetState createState() => _PaymentSelectionWidgetState();
}

class _PaymentSelectionWidgetState extends State<PaymentSelectionWidget> {
  int _selectedIndex = -1; // Initially no item is selected

  void _handleItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(right: 114.h),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          width: 30.h,
        );
      },
      itemCount: 3, // Change itemCount to 3 for three cards
      itemBuilder: (context, index) {
        // Provide each PaymentItemWidget with a corresponding card type
        String cardType;
        switch (index) {
          case 0:
            cardType = 'VisaCard';
            break;
          case 1:
            cardType = 'Mastercard';
            break;
          case 2:
            cardType = 'Mir';
            break;
          default:
            cardType = 'VisaCard'; // Default to Visa card
        }

        return PaymentItemWidget(
          cardType: cardType,
          isSelected: _selectedIndex == index,
          onTap: () => _handleItemTap(index),
        );
      },
    );
  }
}
