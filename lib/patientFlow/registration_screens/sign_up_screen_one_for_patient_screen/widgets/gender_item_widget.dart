import 'package:flutter/material.dart';
import 'package:doctari/core/app_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class GenderItemWidget extends StatelessWidget {
  const GenderItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Text(
      "${AppLocalizations.of(context)!.genderDoctorProfileScrenSC}",
      style: theme.textTheme.bodyLarge,
    );
  }
}
