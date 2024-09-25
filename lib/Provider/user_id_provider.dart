import 'package:flutter/material.dart';

class ProviderForStoringValues extends ChangeNotifier {
  int? patientId;
  int? doctorId;
  String? accessToken;

  int _patientCount = 0;

  int get patientCount => _patientCount;

  void setPatientId(int id) {
    patientId = id;
    notifyListeners();
  }

  void setDoctorId(int id) {
    doctorId = id;
    notifyListeners();
  }

  void setAccessToken(String Token) {
    accessToken = Token;
    notifyListeners();
  }

  void updatePatientCount(int count) {
    _patientCount = count;
    notifyListeners(); // Notify listeners that the state has changed
  }
}
