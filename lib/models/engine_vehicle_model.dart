// engine_vehicle_model.dart
class EngineVehicleModel {
  // Customer Information
  String customerName = '';
  String makeModel = '';
  String workshopName = '';
  String jobReference = '';
  String crisVinNumber = '';
  String vehicleRegistration = '';
  String mileage = '';
  DateTime? serviceDate = DateTime.now();

  // Mini Service Form Data
  Map<String, Map<String, String>> miniServiceData = {};
  String comments = '';

  // Constructor
  EngineVehicleModel();

  // Helper method to add mini service data
  void addMiniServiceData(String category, Map<String, String> selections) {
    miniServiceData[category] = selections;
  }

  // Get overall status for a category
  String getCategoryStatus(String category) {
    final data = miniServiceData[category];
    if (data == null || data.isEmpty) return '';

    final values = data.values.toSet();
    if (values.length == 1) return values.first;
    return 'Mixed';
  }
}
