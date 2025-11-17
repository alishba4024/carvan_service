import 'dart:typed_data';

import 'package:data/models/safety_inspection_model.dart';
import 'package:data/services/safety_inspection_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

class SafetyInspectionStepController extends GetxController {
  var currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < 8) {
      // 0-8 for 9 steps
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 8) {
      currentStep.value = step;
    }
  }
}

class SafetyInspectionForm extends StatefulWidget {
  const SafetyInspectionForm({super.key});

  @override
  State<SafetyInspectionForm> createState() => _SafetyInspectionFormState();
}

class _SafetyInspectionFormState extends State<SafetyInspectionForm> {
  final SafetyInspectionStepController stepController = Get.put(
    SafetyInspectionStepController(),
  );

  // CORRECTED Form data storage
  String vehicleRegistration = ''; // Was customerName
  String mileage = ''; // Was makeModel
  String makeModel = ''; // Was workshopName
  String workshopName = '';
  String jobReference = '';
  String operatorName = ''; // Was crisVinNumber
  String comments = '';
  String insiderCabComments = '';
  String vehicleGroundLevelComments = '';

  // Store selected values for each individual item
  Map<String, String> selectedValues = {};

  // Store detailed inspection data for each individual item
  Map<String, Map<String, String>> inspectionData = {};

  // Store Inspection Report data
  String seenOn = '';
  String signedBy = '';
  String tmOperator = '';

  // Store new sections data
  String checkNumber = '';
  String faultDetails = '';
  String signatureOfInspector = '';
  String nameOfInspector = '';
  String actionTakenOnFault = '';
  String rectifiedBy = '';
  String rectifiedSatisfactorily = '';
  String needsMoreWorkDone = '';
  String signatureOfMechanic = '';
  String date = '';

  final List<String> stepTitles = [
    'Customer Information',
    'Insider Cab',
    'Vehicle Ground Level',
    'Brake Performance',
    'General Servicing',
    'Inspection Report',
    'Comments on faults found',
    'Action taken on faults found',
    'Consider defects have',
  ];

  final List<String> dropdownOptions = ["V", "R", "X", "N/A"];

  void _collectFormData() {
    print('=== SAFETY INSPECTION DATA ===');
    print('Vehicle Registration: $vehicleRegistration');
    print('Mileage: $mileage');
    print('Make & Model: $makeModel');
    print('Workshop Name: $workshopName');
    print('Job Reference: $jobReference');
    print('Operator: $operatorName');
    print('Insider Cab Comments: $insiderCabComments');
    print('Vehicle Ground Level Comments: $vehicleGroundLevelComments');
    print('Final Comments: $comments');
    print('Inspection Data: $inspectionData');
    print('Inspection Report - Seen On: $seenOn');
    print('Inspection Report - Signed By: $signedBy');
    print('Inspection Report - TM Operator: $tmOperator');
    print('Comments on faults found - Check Number: $checkNumber');
    print('Comments on faults found - Fault Details: $faultDetails');
    print(
      'Comments on faults found - Signature Of Inspector: $signatureOfInspector',
    );
    print('Comments on faults found - Name Of Inspector: $nameOfInspector');
    print(
      'Action taken on faults found - Action taken on fault: $actionTakenOnFault',
    );
    print('Action taken on faults found - Rectified by: $rectifiedBy');
    print(
      'Consider defects have - Rectified satisfactorily: $rectifiedSatisfactorily',
    );
    print('Consider defects have - Needs more work done: $needsMoreWorkDone');
    print(
      'Consider defects have - Signature Of Mechanic: $signatureOfMechanic',
    );
    print('Consider defects have - Date: $date');
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
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const Spacer(),
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

            Expanded(
              child: Container(
                color: const Color(0xFFF8F8F8),
                child: Obx(() {
                  int currentStep = stepController.currentStep.value;
                  return _buildStepContent(currentStep, width);
                }),
              ),
            ),

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
                          onPressed: () {
                            _exportToPdf();
                            Get.snackbar(
                              'Success',
                              'Form completed successfully',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          },
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
        return _buildInspectionSection('Insider Cab', isSmallScreen);
      case 2:
        return _buildInspectionSection('Vehicle Ground Level', isSmallScreen);
      case 3:
        return _buildInspectionSection('Brake Performance', isSmallScreen);
      case 4:
        return _buildInspectionSection('General Servicing', isSmallScreen);
      case 5:
        return _buildInspectionReportSection(isSmallScreen);
      case 6:
        return _buildCommentsOnFaultsFoundSection(isSmallScreen);
      case 7:
        return _buildActionTakenOnFaultsFoundSection(isSmallScreen);
      case 8:
        return _buildConsiderDefectsHaveSection(isSmallScreen);
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
            'Enter* Vehicle Registration',
            (value) => vehicleRegistration = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Odometer Reading',
            (value) => mileage = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Make & Type',
            (value) => makeModel = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Workshop Name',
            (value) => workshopName = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Date Of Inspection',
            (value) => jobReference = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Operator',
            (value) => operatorName = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildInspectionReportSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inspection Report',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 25),

          _buildTextFieldWithHint(
            'Enter* Seen on',
            (value) => seenOn = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Signed by',
            (value) => signedBy = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* TM Operator',
            (value) => tmOperator = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildCommentsOnFaultsFoundSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments on faults found',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 25),

          _buildTextFieldWithHint(
            'Enter* Check Number',
            (value) => checkNumber = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Fault Details',
            (value) => faultDetails = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Signature Of Inspector',
            (value) => signatureOfInspector = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Name Of Inspector',
            (value) => nameOfInspector = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildActionTakenOnFaultsFoundSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Action taken on faults found',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 25),

          _buildTextFieldWithHint(
            'Enter* Action taken on fault',
            (value) => actionTakenOnFault = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Rectified by',
            (value) => rectifiedBy = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildConsiderDefectsHaveSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consider defects have',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 25),

          _buildTextFieldWithHint(
            'Enter* (IF) Rectified satisfactorily',
            (value) => rectifiedSatisfactorily = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* (IF) Needs more work done',
            (value) => needsMoreWorkDone = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* (IF) Signature Of Mechanic',
            (value) => signatureOfMechanic = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildTextFieldWithHint(
            'Enter* Date',
            (value) => date = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildInspectionSection(String sectionTitle, bool isSmallScreen) {
    Map<String, List<String>> sectionItems = {
      'Insider Cab': [
        'Drivers seat*',
        'Seat belts*',
        'Mirrors*',
        'Glass & Road View*',
        'Accessibility Features*',
        'Horn*',
      ],
      'Vehicle Ground Level': [
        'Security of body*',
        'Exhaust emission*',
        'Road wheels & hubs*',
        'Size & types of tyres*',
        'Condition of tyres*',
        'Bumper bars*',
      ],
      'Brake Performance': [
        'Service Brake Performance*',
        'Brake Performance*',
        'Parking Brake Performance*',
      ],
      'General Servicing': [
        'Vehicle excise duty*',
        'PSV*',
        'Technograph calibration*',
      ],
    };

    List<String> items = sectionItems[sectionTitle] ?? [];

    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 15),

          ...List.generate(items.length, (index) {
            String item = items[index];
            String selectedValue = selectedValues[item] ?? '';

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
                          _showIndividualSelectionPopup(item, sectionTitle);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Comments field for Insider Cab section
          if (sectionTitle == 'Insider Cab') ...[
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              onChanged: (value) => insiderCabComments = value,
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
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Comments field for Vehicle Ground Level section
          if (sectionTitle == 'Vehicle Ground Level') ...[
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              onChanged: (value) => vehicleGroundLevelComments = value,
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
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Comments field for Brake Performance section
          if (sectionTitle == 'Brake Performance') ...[
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              onChanged: (value) => comments = value,
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
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Comments field for General Servicing section
          if (sectionTitle == 'General Servicing') ...[
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              onChanged: (value) => comments = value,
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
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
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

  void _showIndividualSelectionPopup(String itemName, String sectionTitle) {
    List<String> getFieldsForItem(String item, String section) {
      switch (item) {
        case 'Drivers seat*':
        case 'Seat belts*':
        case 'Mirrors*':
        case 'Glass & Road View*':
        case 'Accessibility Features*':
        case 'Horn*':
        case 'Security of body*':
        case 'Exhaust emission*':
        case 'Road wheels & hubs*':
        case 'Size & types of tyres*':
        case 'Condition of tyres*':
        case 'Bumper bars*':
          return [
            'Item inspected',
            'Serviceable',
            'Defect found',
            'Rectified by',
          ];
        case 'Service Brake Performance*':
        case 'Brake Performance*':
        case 'Parking Brake Performance*':
          return ['Item inspected', '% Percent'];
        case 'Vehicle excise duty*':
        case 'PSV*':
        case 'Technograph calibration*':
          return ['Item inspected', 'Due Date'];
        default:
          return [
            'Item inspected',
            'Serviceable',
            'Defect found',
            'Rectified by',
          ];
      }
    }

    List<String> fields = getFieldsForItem(itemName, sectionTitle);

    Map<String, String> tempSelections = {};
    final currentData = inspectionData[itemName] ?? {};
    for (var field in fields) {
      if (currentData.containsKey(field)) {
        tempSelections[field] = currentData[field]!;
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

                    if (sectionTitle == 'Brake Performance' ||
                        sectionTitle == 'General Servicing') ...[
                      ...fields.map((field) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: TextField(
                                  controller: TextEditingController(
                                    text: tempSelections[field] ?? '',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Enter* $field",
                                    hintStyle: const TextStyle(
                                      fontFamily: "PolySans",
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(
                                      top: 12,
                                      left: 12,
                                      right: 12,
                                    ),
                                    isDense: true,
                                  ),
                                  style: const TextStyle(
                                    fontFamily: "PolySans",
                                    fontSize: 14,
                                  ),
                                  onChanged: (value) {
                                    setModalState(() {
                                      tempSelections[field] = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ] else ...[
                      ...fields.map((field) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Select* $field ",
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
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: tempSelections[field],
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
                                        tempSelections[field] = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
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
                            selectedValues[itemName] = overallStatus;
                            inspectionData[itemName] = Map.from(tempSelections);

                            print('Stored data for $itemName: $tempSelections');
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
            content: const Text(
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

  void _exportToPdf() async {
    try {
      _collectFormData();

      // CORRECTED data mapping
      final formData =
          SafetyInspectionModel()
            ..vehicleRegistration = vehicleRegistration
            ..mileage = mileage
            ..makeModel = makeModel
            ..workshopName = workshopName
            ..jobReference = jobReference
            ..operator = operatorName
            ..insiderCabComments = insiderCabComments
            ..vehicleGroundLevelComments = vehicleGroundLevelComments
            ..comments = comments
            ..inspectionData = inspectionData
            ..selectedValues = selectedValues
            ..seenOn = seenOn
            ..signedBy = signedBy
            ..tmOperator = tmOperator
            ..checkNumber = checkNumber
            ..faultDetails = faultDetails
            ..signatureOfInspector = signatureOfInspector
            ..nameOfInspector = nameOfInspector
            ..actionTakenOnFault = actionTakenOnFault
            ..rectifiedBy = rectifiedBy
            ..rectifiedSatisfactorily = rectifiedSatisfactorily
            ..needsMoreWorkDone = needsMoreWorkDone
            ..signatureOfMechanic = signatureOfMechanic
            ..date = date;

      final ByteData byteData = await rootBundle.load('assets/images/logo.png');
      final Uint8List logoBytes = byteData.buffer.asUint8List();

      final pdfBytes = await SafetyInspectionPdfService.generatePdf(
        formData,
        logoImageBytes: logoBytes,
      );

      await Printing.sharePdf(
        bytes: pdfBytes,
        filename:
            'safety-inspection-${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

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
