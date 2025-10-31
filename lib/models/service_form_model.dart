class ServiceFormModel {
  // Customer Information
  String customerName = '';
  String makeModel = '';
  String workshopName = '';
  String jobReference = '';
  String crisVinNumber = '';
  DateTime? serviceDate;

  // Underbody
  Map<String, String> chassisRunningGear = {
    'Corner Steadies': '',
    'Folding Steps': '',
    'Under Slung Tanks & Pipes': '',
    // 'Breakaway cable & clip': '',
    // 'Drawbar': '',
    // 'Corner steadies': '',
    // 'Spare wheel carrier': '',
    // 'Jockey wheel': '',
    // 'Chassis': '',
    // 'Braking system': '',
    // 'Wheels & tyres': '',
    // 'Suspension & axle': '',
    // 'Handbrake mechanism': '',
  };

  // Electrical System
  Map<String, String> electricalSystem = {
    '13 pin/7 pin plugs, cables & storage position': '',
    'Road lights & reflectors': '',
    'Leisure battery': '',
    'Battery compartment': '',
    '230V & 12V fridge operation': '',
    'Interior lighting & equipment': '',
    'Awning light': '',
    'Wiring on ELV circuits': '',
    'LV inlet plug & extension lead': '',
    'Earth bonding continuity test': '',
    '230V consumer unit load test RCD': '',
    '230V sockets': '',
    'Charge voltage': '',
    'Check operation of all 230V appliances': '',
    'Check all aftermarket items': '',
  };

  // Water System
  Map<String, String> waterSystem = {
    'Water pump & pressure switch/microswitches': '',
    'Taps, valves, pipes & tank': '',
    'Water inlets': '',
    'Waste system': '',
    'Toilet': '',
  };

  // Bodywork
  Map<String, String> bodywork = {
    'Doors & windows': '',
    'General condition of bodywork including roof': '',
    'External seals & bonded joints condition': '',
    'Roof straps': '',
    'Grab handles': '',
    'Number plate': '',
    'Floor': '',
    'Furniture': '',
    'Blinds & fly screens': '',
    'Rising roof': '',
    'Damp test': '',
  };

  // Ventilation
  Map<String, String> ventilation = {
    'Fixed ventilation': '',
    'Roof lights': '',
  };

  // Fire & Safety
  Map<String, String> fireSafety = {
    'Smoke alarm test': '',
    'CO alarm test': '',
    'Fire extinguisher security': '',
    'Smoke alarm expiry date': '',
    'Carbon monoxide alarm expiry date': '',
  };

  // LPG Gas System
  Map<String, String> gasSystem = {
    'Regulator, gas hose, pipework & manifold': '',
    'Gas tightness check': '',
    'Appliances operation': '',
    'Security of gas cylinder(s)': '',
    'Gas dispersal vents': '',
  };

  // Finalization Section
  String serviceInfo = '';
  bool eicrOffered = false;
  String wheelTorqueSetting = '';
  String technicianName = '';
  String doubleCheckName = '';

  // Tyre Information
  Map<String, Map<String, String>> tyres = {
    'N/S/F': {'age': '', 'pressure': '', 'tread': ''},
    'N/S/R': {'age': '', 'pressure': '', 'tread': ''},
    'O/S/F': {'age': '', 'pressure': '', 'tread': ''},
    'O/S/R': {'age': '', 'pressure': '', 'tread': ''},
    'Spare': {'age': '', 'pressure': '', 'tread': ''},
  };

  // Electrical Tests
  String batteryRestVoltage = '';
  String chargerVoltage = '';
  String rcdTest1x = '';
  String rcdTest5x = '';
  String earthBondChassis = '';
  String earthBondGas = '';

  // Gas System Details
  String gasHoseExpiry = '';
  String regulatorAge = '';

  // Final Checks
  Map<String, bool> finalChecks = {
    'Gas turned off': false,
    'Roof lights latched': false,
    'Windows locked': false,
    'All cupboards closed/latched': false,
    'Exterior lockers locked': false,
    'Exterior door locked': false,
    'Lights turned off': false,
    'Water pump turned off': false,
    '12V/main power switch turned off': false,
    'Old parts left in tourer': false,
    'All protective coverings removed': false,
    'Service book stamped': false,
  };
}
