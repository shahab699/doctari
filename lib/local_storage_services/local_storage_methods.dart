import 'package:doctari/local_storage_services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageMethods {
  LocalStorageMethods._();
  static final instance = LocalStorageMethods._();

  Future<void> writeSelectedTimeSlot(String selectedTimeSlot) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? alreadyStoredSlots = prefs.getStringList("listOfSelectedTime") ?? [];

    if (!alreadyStoredSlots.contains(selectedTimeSlot)) {
      alreadyStoredSlots.add(selectedTimeSlot);
      await prefs.setStringList("listOfSelectedTime", alreadyStoredSlots);
    }
  }

  Future<List<String>> getSelectedTimeSlotsList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("listOfSelectedTime") ?? [];
  }
}

// class LocalStorageMethods {
//   LocalStorageMethods._();
//   static final instance = LocalStorageMethods._();

//   //// current address
//   Future<void> writeSelectedTimeSlot(String selectedTimeSlot) async {
//     List<String> inputList = [selectedTimeSlot];
//     List<String> alreadyStoredSlots = getSelectedTimeSlotsList() ?? [];

//     if (!alreadyStoredSlots.contains(selectedTimeSlot)) {
//       inputList.addAll(alreadyStoredSlots);
//       await Prefs.setStringList("listOfSelectedTime", inputList);
//     }
//   }

//   List<String>? getSelectedTimeSlotsList() {
//     return Prefs.getStringList("listOfSelectedTime");
//   }
// }
