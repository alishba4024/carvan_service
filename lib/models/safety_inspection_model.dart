class SafetyInspectionModel {
  String vehicleRegistration = '';
  String mileage = '';
  String makeModel = '';
  String workshopName = '';
  String jobReference = '';
  String operator = '';
  String comments = '';
  String insiderCabComments = '';
  String vehicleGroundLevelComments = '';

  // Inspection data
  Map<String, String> selectedValues = {};
  Map<String, Map<String, String>> inspectionData = {};

  // Inspection Report section
  String seenOn = '';
  String signedBy = '';
  String tmOperator = '';

  // Comments on faults found section
  String checkNumber = '';
  String faultDetails = '';
  String signatureOfInspector = '';
  String nameOfInspector = '';

  // Action taken on faults found section
  String actionTakenOnFault = '';
  String rectifiedBy = '';

  // Consider defects have section
  String rectifiedSatisfactorily = '';
  String needsMoreWorkDone = '';
  String signatureOfMechanic = '';
  String date = '';

  DateTime? inspectionDate;

  SafetyInspectionModel({this.inspectionDate}) {
    inspectionDate ??= DateTime.now();
  }
}
