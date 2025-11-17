import 'dart:typed_data'; // Add this import for ByteData
import 'package:data/models/engine_vehicle_model.dart';
import 'package:data/services/engine_vehicle_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

class EngineVehicleStepController extends GetxController {
  var currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < 1) {
      // Only 2 steps: 0 and 1
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    currentStep.value = step;
  }
}

class EngineVehicleServiceForm extends StatefulWidget {
  @override
  _EngineVehicleServiceFormState createState() =>
      _EngineVehicleServiceFormState();
}

class _EngineVehicleServiceFormState extends State<EngineVehicleServiceForm> {
  final EngineVehicleModel formData = EngineVehicleModel();
  final EngineVehicleStepController stepController = Get.put(
    EngineVehicleStepController(),
  );

  final List<String> stepTitles = ['Customer Information', 'Mini Service Form'];

  // Store selected values for each field
  Map<String, String> selectedValues = {
    'Parts Included': '',
    'Top-ups Included': '',
    'General Checks': '',
    'Internal/Vision': '',
    'Engine': '',
    'Brake': '',
    'Wheels & Tyres': '',
    'Steering & Suspension': '',
    'Exhaust': '',
  };

  final List<String> dropdownOptions = ["P", "F", "N/A", "R"];

  // Add this method to collect all form data
  void _collectFormData() {
    // Debug: Print the current state of miniServiceData BEFORE any changes
    print('=== BEFORE COLLECTION ===');
    print('Mini Service Data: ${formData.miniServiceData}');
    print('Selected Values: $selectedValues');

    // Debug: Print the final state
    print('=== AFTER COLLECTION ===');
    print('Mini Service Data: ${formData.miniServiceData}');
    print('======================');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isSmallScreen = width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Get.back();
                    },
                  ),

                  const Spacer(),

                  // Logo
                  Container(
                    width: isSmallScreen ? 170 : 220,
                    height: isSmallScreen ? 70 : 80,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),

            // Step indicator
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Expanded(child: Container(height: 1, color: Colors.black)),
                    const SizedBox(width: 10),
                    Text(
                      '(STEP ${stepController.currentStep.value + 1} OF ${stepTitles.length})',
                      style: TextStyle(
                        fontFamily: 'PolySans',
                        fontSize: isSmallScreen ? 15 : 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Container(height: 1, color: Colors.black)),
                  ],
                ),
              ),
            ),

            // Form Content
            Expanded(
              child: Container(
                color: const Color(0xFFF8F8F8),
                child: Obx(() {
                  int currentStep = stepController.currentStep.value;
                  return _buildStepContent(currentStep, width);
                }),
              ),
            ),

            // Navigation Buttons
            Obx(
              () => Container(
                padding: const EdgeInsets.all(20),
                color: const Color(0xFFF8F8F8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (stepController.currentStep.value > 0)
                          OutlinedButton(
                            onPressed: stepController.previousStep,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.black),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 30 : 40,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Go Back',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    color: Colors.black,
                                    fontFamily: 'PolySans',
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          OutlinedButton(
                            onPressed: _showExitConfirmation,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.black),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 30 : 40,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Go Back',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    color: Colors.black,
                                    fontFamily: 'PolySans',
                                  ),
                                ),
                              ],
                            ),
                          ),

                        if (stepController.currentStep.value <
                            stepTitles.length - 1)
                          OutlinedButton(
                            onPressed:
                                () => stepController.goToStep(
                                  stepController.currentStep.value + 1,
                                ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xff173EA6),
                              side: BorderSide(color: const Color(0xff173EA6)),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 30 : 40,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Skip To Next',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                color: const Color(0xff173EA6),
                                fontFamily: 'PolySans',
                              ),
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),

                    const SizedBox(height: 12),

                    if (stepController.currentStep.value <
                        stepTitles.length - 1)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: stepController.nextStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff173EA6),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Proceed Next',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'PolySans',
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _exportToPdf,
                          icon: const Icon(Icons.picture_as_pdf, size: 20),
                          label: Text(
                            'Export PDF',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'PolySans',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(int step, double width) {
    bool isSmallScreen = width < 600;

    switch (step) {
      case 0:
        return _buildCustomerInfoSection(isSmallScreen);
      case 1:
        return _buildMiniServiceSection(isSmallScreen);
      default:
        return Container();
    }
  }

  Widget _buildCustomerInfoSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Information',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 25),

          _buildTextFieldWithHint(
            'Enter* Customer Name',
            (value) => formData.customerName = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Make & Model',
            (value) => formData.makeModel = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Workshop Name',
            (value) => formData.workshopName = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Job Reference',
            (value) => formData.jobReference = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* CRIS/Vin Number',
            (value) => formData.crisVinNumber = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Vehicle Registration',
            (value) =>
                formData.vehicleRegistration = value, // Fixed this callback
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Mileage',
            (value) => formData.mileage = value, // Fixed this callback
            isSmallScreen,
          ),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildMiniServiceSection(bool isSmallScreen) {
    final items = [
      "Parts Included*",
      "Top-ups Included*",
      "General Checks*",
      "Internal/Vision*",
      "Engine*",
      "Brake*",
      "Wheels & Tyres*",
      "Steering & Suspension*",
      "Exhaust*",
      "Drive System*",
    ];

    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mini Service',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 15),

          // List items like screenshot
          ...List.generate(items.length, (index) {
            String item = items[index];
            String selectedValue =
                selectedValues[item.replaceAll('*', '').trim()] ?? '';

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "$item Select Details",
                                style: TextStyle(
                                  fontFamily: 'PolySans',
                                  fontSize: isSmallScreen ? 13.5 : 15,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            if (selectedValue.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.green.shade300,
                                  ),
                                ),
                                child: Text(
                                  selectedValue,
                                  style: TextStyle(
                                    fontFamily: 'PolySans',
                                    fontSize: 12,
                                    color: Colors.green.shade800,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 55,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xff173EA6),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.open_in_new,
                          size: 22,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _showSelectionPopup(item);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          //COMMENTS FIELD BELOW EXHAUST
          const SizedBox(height: 10),
          TextField(
            maxLines: 6,
            onChanged:
                (value) =>
                    formData.comments = value, // Add this to capture comments
            decoration: InputDecoration(
              hintText: "Enter* Comments (Optional)",
              hintStyle: TextStyle(
                fontFamily: "PolySans",
                fontSize: isSmallScreen ? 14 : 16,
                color: Colors.grey.shade600,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.4),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildFormContainer(Widget child, bool isSmallScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      child: Container(
        margin: EdgeInsets.all(isSmallScreen ? 8 : 16),
        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  Widget _buildTextFieldWithHint(
    String hint,
    Function(String) onChanged,
    bool isSmallScreen,
  ) {
    return Container(
      height: isSmallScreen ? 50 : 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          isDense: true,
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: isSmallScreen ? 14 : 16,
            fontFamily: 'PolySans',
          ),
        ),
        style: TextStyle(
          fontSize: isSmallScreen ? 14 : 16,
          fontFamily: 'PolySans',
        ),
        onChanged: onChanged,
      ),
    );
  }

  void _showSelectionPopup(String fieldName) {
    // Remove asterisks and trim the field name for proper matching
    String cleanFieldName = fieldName.replaceAll('*', '').trim();

    // Different content based on field name
    Map<String, List<String>> fieldOptions = {
      'Parts Included': ['Engine Oil', 'Oil Filter'],
      'Top-ups Included': [
        'Windscreen Additive',
        'Coolant',
        'Brake Fluid',
        'Power Steering Fluid',
      ],
      'General Checks': ['External Lights', 'Instrument warning'],
      'Internal/Vision': ['Condition of Windscreen', 'Wiper and Washers'],
      'Engine': ['General Oil Leaks', 'Antifreeze Strength', 'Timing Belt'],
      'Brake': ['Visual Check of brake pads'],
      'Wheels & Tyres': ['Tyre Condition', 'Tyre Pressure'],
      'Steering & Suspension': ['Steering Rack condition'],
      'Exhaust': ['Exhaust condition'],
      'Drive System': ['Clutch Fluid level', 'Transmission oil'],
    };

    // Use cleanFieldName for matching
    List<String> options =
        fieldOptions[cleanFieldName] ?? ['Check 1', 'Check 2', 'Check 3'];

    // Initialize tempSelections with current values if they exist
    Map<String, String> tempSelections = {};
    final currentData = formData.miniServiceData[cleanFieldName] ?? {};
    for (var option in options) {
      if (currentData.containsKey(option)) {
        tempSelections[option] = currentData[option]!;
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              insetPadding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header - Show the actual field name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Select Options",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "PolySans",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 22),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    const SizedBox(height: 15),

                    // Dynamic options based on field
                    ...options.map((option) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: const TextStyle(
                                  fontFamily: "PolySans",
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: tempSelections[option],
                                  isExpanded: true,
                                  items:
                                      dropdownOptions.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Center(
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                fontFamily: "PolySans",
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    setModalState(() {
                                      tempSelections[option] = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Determine overall status (show first selected or "Mixed" if different)
                          String overallStatus = "Not Selected";
                          if (tempSelections.isNotEmpty) {
                            List<String> uniqueValues =
                                tempSelections.values.toSet().toList();
                            overallStatus =
                                uniqueValues.length == 1
                                    ? uniqueValues.first
                                    : "Mixed";
                          }

                          setState(() {
                            selectedValues[cleanFieldName] = overallStatus;
                            // Store detailed selections in the model
                            formData.addMiniServiceData(
                              cleanFieldName,
                              Map.from(tempSelections),
                            );

                            // Debug: Print what's being stored
                            print(
                              'Stored data for $cleanFieldName: $tempSelections',
                            );
                            print('Overall status: $overallStatus');
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff173EA6),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontFamily: "PolySans",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Exit Form?', style: TextStyle(fontFamily: 'PolySans')),
            content: Text(
              'Are you sure you want to go back? Your progress may not be saved.',
              style: TextStyle(fontFamily: 'PolySans'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: 'PolySans',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Exit',
                  style: TextStyle(
                    color: const Color(0xff173EA6),
                    fontFamily: 'PolySans',
                  ),
                ),
              ),
            ],
          ),
    );
  }

  // Update the _exportToPdf method
  void _exportToPdf() async {
    try {
      // First collect all form data
      _collectFormData();

      // Load logo image
      final ByteData byteData = await rootBundle.load('assets/images/logo.png');
      final Uint8List logoBytes = byteData.buffer.asUint8List();

      final pdfBytes = await EngineVehiclePdfService.generatePdf(
        formData,
        logoImageBytes: logoBytes,
      );

      await Printing.sharePdf(
        bytes: pdfBytes,
        filename:
            'engine-vehicle-service-${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      // Show success message
      Get.snackbar(
        'Success',
        'PDF exported successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('PDF Export Error: $e');
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Export Error'),
              content: Text('Failed to generate PDF: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }
}
