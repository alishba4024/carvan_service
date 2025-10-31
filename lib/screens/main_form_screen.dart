// import 'package:data/models/service_form_model.dart';
// import 'package:data/services/pdf_export_service.dart';
// import 'package:data/widgets/section_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';
// import 'package:get/get.dart';

// class StepController extends GetxController {
//   var currentStep = 0.obs;

//   void nextStep() {
//     if (currentStep.value < 10) {
//       currentStep.value++;
//     }
//   }

//   void previousStep() {
//     if (currentStep.value > 0) {
//       currentStep.value--;
//     }
//   }

//   void goToStep(int step) {
//     currentStep.value = step;
//   }
// }

// class MainFormScreen extends StatefulWidget {
//   @override
//   _MainFormScreenState createState() => _MainFormScreenState();
// }

// class _MainFormScreenState extends State<MainFormScreen> {
//   final ServiceFormModel formData = ServiceFormModel();
//   final _formKey = GlobalKey<FormState>();
//   final List<String> statusOptions = ['P', 'F', 'N/A', 'R'];
//   final StepController stepController = Get.put(StepController());

//   final List<String> stepTitles = [
//     'Main Information', // ✅ new screen
//     'Customer Info',
//     'Underbody',
//     'Electrical System',
//     'Water System',
//     'Bodywork',
//     'Ventilation & Safety',
//     'Gas System',
//     'Tyre Information',
//     'Electrical Tests',
//     'Finalization',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     bool isSmallScreen = width < 600;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(top: 30),
//               child: Center(
//                 child: Container(
//                   width: isSmallScreen ? 170 : 220,
//                   height: isSmallScreen ? 70 : 80,
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),

//             Obx(
//               () => Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 25,
//                   horizontal: 20,
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(child: Container(height: 1, color: Colors.black)),
//                     const SizedBox(width: 10),
//                     Text(
//                       '(STEP ${stepController.currentStep.value + 1} OF ${stepTitles.length})',
//                       style: TextStyle(
//                         fontFamily: 'PolySans',
//                         fontSize: isSmallScreen ? 15 : 17,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(child: Container(height: 1, color: Colors.black)),
//                   ],
//                 ),
//               ),
//             ),

//             Expanded(
//               child: Container(
//                 color: const Color(0xFFF8F8F8),
//                 child: Obx(() {
//                   int currentStep = stepController.currentStep.value;
//                   return _buildStepContent(currentStep, width);
//                 }),
//               ),
//             ),

//             Obx(
//               () => Container(
//                 padding: const EdgeInsets.all(20),
//                 color: const Color(0xFFF8F8F8),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         if (stepController.currentStep.value > 0)
//                           OutlinedButton(
//                             onPressed: stepController.previousStep,
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.black,
//                               side: BorderSide(color: Colors.black),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: isSmallScreen ? 30 : 40,
//                                 vertical: 12,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.arrow_back,
//                                   size: 16,
//                                   color: Colors.black,
//                                 ),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   'Go Back',
//                                   style: TextStyle(
//                                     fontSize: isSmallScreen ? 14 : 16,
//                                     color: Colors.black,
//                                     fontFamily: 'PolySans',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         else
//                           Container(),

//                         if (stepController.currentStep.value <
//                             stepTitles.length - 1)
//                           OutlinedButton(
//                             onPressed:
//                                 () => stepController.goToStep(
//                                   stepController.currentStep.value + 1,
//                                 ),
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: const Color(0xff173EA6),
//                               side: BorderSide(color: const Color(0xff173EA6)),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: isSmallScreen ? 30 : 40,
//                                 vertical: 12,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: Text(
//                               'Skip To Next',
//                               style: TextStyle(
//                                 fontSize: isSmallScreen ? 14 : 16,
//                                 color: const Color(0xff173EA6),
//                                 fontFamily: 'PolySans',
//                               ),
//                             ),
//                           )
//                         else
//                           Container(),
//                       ],
//                     ),

//                     const SizedBox(height: 12),

//                     if (stepController.currentStep.value <
//                         stepTitles.length - 1)
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: stepController.nextStep,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xff173EA6),
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 24,
//                               vertical: 16,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: Text(
//                             'Proceed Next',
//                             style: TextStyle(
//                               fontSize: isSmallScreen ? 16 : 18,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'PolySans',
//                             ),
//                           ),
//                         ),
//                       )
//                     else
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: _exportToPdf,
//                           icon: const Icon(Icons.picture_as_pdf, size: 20),
//                           label: Text(
//                             'Export PDF',
//                             style: TextStyle(
//                               fontSize: isSmallScreen ? 16 : 18,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'PolySans',
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green.shade600,
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 24,
//                               vertical: 16,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             elevation: 0,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFormContainer(Widget child, bool isSmallScreen) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           minHeight: 430, // Minimum height
//         ),
//         child: Container(
//           margin: EdgeInsets.all(isSmallScreen ? 8 : 16),
//           padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 4,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }

//   Widget _buildStepContent(int step, double width) {
//     bool isSmallScreen = width < 600;

//     switch (step) {
//       case 0:
//         return _buildMainInformationSection(isSmallScreen); // ✅ new screen
//       case 1:
//         return _buildCustomerInfoSection(isSmallScreen);
//       case 2:
//         return _buildChassisRunningGearSection(isSmallScreen);
//       case 3:
//         return _buildElectricalSystemSection(isSmallScreen);
//       case 4:
//         return _buildWaterSystemSection(isSmallScreen);
//       case 5:
//         return _buildBodyworkSection(isSmallScreen);
//       case 6:
//         return _buildVentilationSafetySection(isSmallScreen);
//       case 7:
//         return _buildGasSystemSection(isSmallScreen);
//       case 8:
//         return _buildTyreInfoSection(isSmallScreen);
//       case 9:
//         return _buildElectricalTestsSection(isSmallScreen);
//       case 10:
//         return _buildFinalizationSection(isSmallScreen);
//       default:
//         return Container();
//     }
//   }

//   //  FIRST STEP
//   Widget _buildMainInformationSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Main Information',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 25),

//           // Upload Box Placeholder
//           Container(
//             height: 160, // Increased from 130 to 150
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.attach_file, color: Colors.grey.shade600),
//                       SizedBox(width: 8),
//                       Text(
//                         "Add* Attachments",
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontFamily: 'PolySans',
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "File Type: MOV,DOC,MP4,JPEG",
//                     style: TextStyle(
//                       color: Colors.grey.shade500,
//                       fontSize: 11,
//                       fontFamily: 'PolySans',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Workshop Name & Address
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: isSmallScreen ? 50 : 55,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'Enter* Approved Workshop Name & Address',
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                     isDense: true,
//                     hintStyle: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: isSmallScreen ? 12 : 14,
//                       fontFamily: 'PolySans',
//                     ),
//                   ),
//                   style: TextStyle(
//                     fontSize: isSmallScreen ? 12 : 14,
//                     fontFamily: 'PolySans',
//                   ),
//                   onChanged: (value) => formData.workshopName = value,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),

//           // Job Reference/Date
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: isSmallScreen ? 50 : 55,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'Enter* Job Reference/Date',
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                     isDense: true,
//                     hintStyle: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: isSmallScreen ? 14 : 16,
//                       fontFamily: 'PolySans',
//                     ),
//                   ),
//                   style: TextStyle(
//                     fontSize: isSmallScreen ? 14 : 16,
//                     fontFamily: 'PolySans',
//                   ),
//                   onChanged: (value) => formData.jobReference = value,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildCustomerInfoSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Customer Information',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 25),

//           // Customer Name
//           Container(
//             height: isSmallScreen ? 50 : 55,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: 'Enter* Customer Name',
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 14,
//                 ),
//                 isDense: true,
//                 hintStyle: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: isSmallScreen ? 14 : 16,
//                   fontFamily: 'PolySans',
//                 ),
//               ),
//               style: TextStyle(
//                 fontSize: isSmallScreen ? 14 : 16,
//                 fontFamily: 'PolySans',
//               ),
//               onChanged: (value) => formData.customerName = value,
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Make & Model
//           Container(
//             height: isSmallScreen ? 50 : 55,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: 'Enter* Make & Model',
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 14,
//                 ),
//                 isDense: true,
//                 hintStyle: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: isSmallScreen ? 14 : 16,
//                   fontFamily: 'PolySans',
//                 ),
//               ),
//               style: TextStyle(
//                 fontSize: isSmallScreen ? 14 : 16,
//                 fontFamily: 'PolySans',
//               ),
//               onChanged: (value) => formData.makeModel = value,
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Workshop Name
//           Container(
//             height: isSmallScreen ? 50 : 55,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: 'Enter* Workshop Name',
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 14,
//                 ),
//                 isDense: true,
//                 hintStyle: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: isSmallScreen ? 14 : 16,
//                   fontFamily: 'PolySans',
//                 ),
//               ),
//               style: TextStyle(
//                 fontSize: isSmallScreen ? 14 : 16,
//                 fontFamily: 'PolySans',
//               ),
//               onChanged: (value) => formData.workshopName = value,
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Job Reference
//           Container(
//             height: isSmallScreen ? 50 : 55,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: 'Enter* Job Reference',
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 14,
//                 ),
//                 isDense: true,
//                 hintStyle: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: isSmallScreen ? 14 : 16,
//                   fontFamily: 'PolySans',
//                 ),
//               ),
//               style: TextStyle(
//                 fontSize: isSmallScreen ? 14 : 16,
//                 fontFamily: 'PolySans',
//               ),
//               onChanged: (value) => formData.jobReference = value,
//             ),
//           ),
//           const SizedBox(height: 16),

//           // CRIS/Vin Number
//           Container(
//             height: isSmallScreen ? 50 : 55,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: 'Enter* CRIS/Vin Number',
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 14,
//                 ),
//                 isDense: true,
//                 hintStyle: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: isSmallScreen ? 14 : 16,
//                   fontFamily: 'PolySans',
//                 ),
//               ),
//               style: TextStyle(
//                 fontSize: isSmallScreen ? 14 : 16,
//                 fontFamily: 'PolySans',
//               ),
//               onChanged: (value) => formData.crisVinNumber = value,
//             ),
//           ),
//           const SizedBox(height: 24),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildChassisRunningGearSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Underbody',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 20),
//           ...formData.chassisRunningGear.entries.map(
//             (entry) => _buildStatusField(entry.key, entry.value, (value) {
//               setState(() {
//                 formData.chassisRunningGear[entry.key] = value;
//               });
//             }, isSmallScreen),
//           ),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildElectricalSystemSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Electrical System',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 20),
//           ...formData.electricalSystem.entries.map(
//             (entry) => _buildStatusField(entry.key, entry.value, (value) {
//               setState(() {
//                 formData.electricalSystem[entry.key] = value;
//               });
//             }, isSmallScreen),
//           ),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildWaterSystemSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Water System',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 20),
//           ...formData.waterSystem.entries.map(
//             (entry) => _buildStatusField(entry.key, entry.value, (value) {
//               setState(() {
//                 formData.waterSystem[entry.key] = value;
//               });
//             }, isSmallScreen),
//           ),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildBodyworkSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Bodywork',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 20),
//           ...formData.bodywork.entries.map(
//             (entry) => _buildStatusField(entry.key, entry.value, (value) {
//               setState(() {
//                 formData.bodywork[entry.key] = value;
//               });
//             }, isSmallScreen),
//           ),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildVentilationSafetySection(bool isSmallScreen) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           _buildFormContainer(
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Ventilation',
//                   style: TextStyle(
//                     fontSize: isSmallScreen ? 20 : 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontFamily: 'PolySans',
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ...formData.ventilation.entries.map(
//                   (entry) => _buildStatusField(entry.key, entry.value, (value) {
//                     setState(() {
//                       formData.ventilation[entry.key] = value;
//                     });
//                   }, isSmallScreen),
//                 ),
//               ],
//             ),
//             isSmallScreen,
//           ),
//           const SizedBox(height: 16),
//           _buildFormContainer(
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Fire & Safety',
//                   style: TextStyle(
//                     fontSize: isSmallScreen ? 20 : 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontFamily: 'PolySans',
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ...formData.fireSafety.entries.map(
//                   (entry) => _buildStatusField(entry.key, entry.value, (value) {
//                     setState(() {
//                       formData.fireSafety[entry.key] = value;
//                     });
//                   }, isSmallScreen),
//                 ),
//               ],
//             ),
//             isSmallScreen,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGasSystemSection(bool isSmallScreen) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           _buildFormContainer(
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'LPG Gas System',
//                   style: TextStyle(
//                     fontSize: isSmallScreen ? 20 : 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontFamily: 'PolySans',
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ...formData.gasSystem.entries.map(
//                   (entry) => _buildStatusField(entry.key, entry.value, (value) {
//                     setState(() {
//                       formData.gasSystem[entry.key] = value;
//                     });
//                   }, isSmallScreen),
//                 ),
//               ],
//             ),
//             isSmallScreen,
//           ),
//           const SizedBox(height: 16),
//           _buildGasDetailsSection(isSmallScreen),
//         ],
//       ),
//     );
//   }

//   Widget _buildTyreInfoSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Tyre Information',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 20),
//           ...formData.tyres.entries.map(
//             (tyre) => _buildTyreRow(tyre.key, tyre.value, isSmallScreen),
//           ),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildElectricalTestsSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Electrical Tests',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildScreenshotTextField(
//             'Battery Rest Voltage',
//             (value) => formData.batteryRestVoltage = value,
//             isSmallScreen,
//           ),
//           const SizedBox(height: 16),
//           _buildScreenshotTextField(
//             'Charger Voltage',
//             (value) => formData.chargerVoltage = value,
//             isSmallScreen,
//           ),
//           const SizedBox(height: 16),
//           _buildScreenshotTextField(
//             'RCD Test 1xI∆n',
//             (value) => formData.rcdTest1x = value,
//             isSmallScreen,
//           ),
//           const SizedBox(height: 16),
//           _buildScreenshotTextField(
//             'RCD Test 5xI∆n',
//             (value) => formData.rcdTest5x = value,
//             isSmallScreen,
//           ),
//           const SizedBox(height: 16),
//           _buildScreenshotTextField(
//             'Earth Bond Chassis (Ω)',
//             (value) => formData.earthBondChassis = value,
//             isSmallScreen,
//           ),
//           const SizedBox(height: 16),
//           _buildScreenshotTextField(
//             'Earth Bond Gas (Ω)',
//             (value) => formData.earthBondGas = value,
//             isSmallScreen,
//           ),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildGasDetailsSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Gas System Details',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildScreenshotTextField(
//             'Gas Hose Expiry/Manufacture Date',
//             (value) => formData.gasHoseExpiry = value,
//             isSmallScreen,
//           ),
//           const SizedBox(height: 16),
//           _buildScreenshotTextField(
//             'Regulator Age',
//             (value) => formData.regulatorAge = value,
//             isSmallScreen,
//           ),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildFinalizationSection(bool isSmallScreen) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           _buildFormContainer(
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Finalization',
//                   style: TextStyle(
//                     fontSize: isSmallScreen ? 20 : 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontFamily: 'PolySans',
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   height: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: 'Service Information/Additional Work',
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.all(16),
//                       alignLabelWithHint: true,
//                     ),
//                     maxLines: 3,
//                     onChanged: (value) => formData.serviceInfo = value,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Text(
//                       'EICR Offered:',
//                       style: TextStyle(
//                         fontSize: isSmallScreen ? 14 : 16,
//                         fontFamily: 'PolySans',
//                       ),
//                     ),
//                     Checkbox(
//                       value: formData.eicrOffered,
//                       onChanged:
//                           (value) => setState(
//                             () => formData.eicrOffered = value ?? false,
//                           ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 _buildScreenshotTextField(
//                   'Wheel Torque Setting (NM)',
//                   (value) => formData.wheelTorqueSetting = value,
//                   isSmallScreen,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildScreenshotTextField(
//                   'Technician Name',
//                   (value) => formData.technicianName = value,
//                   isSmallScreen,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildScreenshotTextField(
//                   'Double Check Name',
//                   (value) => formData.doubleCheckName = value,
//                   isSmallScreen,
//                 ),
//               ],
//             ),
//             isSmallScreen,
//           ),
//           const SizedBox(height: 16),
//           _buildFinalChecksSection(isSmallScreen),
//         ],
//       ),
//     );
//   }

//   Widget _buildFinalChecksSection(bool isSmallScreen) {
//     return _buildFormContainer(
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Final Checks',
//             style: TextStyle(
//               fontSize: isSmallScreen ? 20 : 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontFamily: 'PolySans',
//             ),
//           ),
//           const SizedBox(height: 20),
//           ...formData.finalChecks.entries.map(
//             (check) => CheckboxListTile(
//               title: Text(
//                 check.key,
//                 style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
//               ),
//               value: check.value,
//               onChanged:
//                   (value) => setState(
//                     () => formData.finalChecks[check.key] = value ?? false,
//                   ),
//             ),
//           ),
//         ],
//       ),
//       isSmallScreen,
//     );
//   }

//   Widget _buildScreenshotTextField(
//     String hint,
//     Function(String) onChanged,
//     bool isSmallScreen,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           hint,
//           style: TextStyle(
//             fontSize: isSmallScreen ? 14 : 16,
//             fontWeight: FontWeight.w500,
//             color: Colors.grey.shade800,
//             fontFamily: 'PolySans',
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: isSmallScreen ? 45 : 50,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey.shade400),
//           ),
//           child: TextFormField(
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 14,
//               ),
//               isDense: true,
//             ),
//             style: TextStyle(
//               fontSize: isSmallScreen ? 14 : 16,
//               fontFamily: 'PolySans',
//             ),
//             onChanged: onChanged,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusField(
//     String label,
//     String value,
//     Function(String) onChanged,
//     bool isSmallScreen,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: isSmallScreen ? 14 : 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey.shade800,
//                 fontFamily: 'PolySans',
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             flex: 1,
//             child: Container(
//               height: isSmallScreen ? 45 : 50,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade400),
//               ),
//               child: DropdownButtonFormField<String>(
//                 value: value.isEmpty ? null : value,
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                   isDense: true,
//                 ),
//                 items:
//                     statusOptions.map((String status) {
//                       return DropdownMenuItem<String>(
//                         value: status,
//                         child: Text(
//                           status,
//                           style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
//                         ),
//                       );
//                     }).toList(),
//                 onChanged: (newValue) => onChanged(newValue ?? ''),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTyreRow(
//     String position,
//     Map<String, String> tyreData,
//     bool isSmallScreen,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Text(
//               position,
//               style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             flex: 1,
//             child: TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Age',
//                 hintText: 'Years',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 8,
//                   vertical: isSmallScreen ? 10 : 12,
//                 ),
//                 isDense: true,
//               ),
//               style: TextStyle(
//                 fontSize: isSmallScreen ? 12 : 14,
//                 fontFamily: 'PolySans',
//               ),
//               onChanged: (value) => tyreData['age'] = value,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             flex: 1,
//             child: TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Pressure',
//                 hintText: 'PSI/BAR',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 8,
//                   vertical: isSmallScreen ? 10 : 12,
//                 ),
//                 isDense: true,
//               ),
//               style: TextStyle(
//                 fontSize: isSmallScreen ? 12 : 14,
//                 fontFamily: 'PolySans',
//               ),
//               onChanged: (value) => tyreData['pressure'] = value,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             flex: 1,
//             child: TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Tread (mm)',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 8,
//                   vertical: isSmallScreen ? 10 : 12,
//                 ),
//                 isDense: true,
//               ),
//               style: TextStyle(
//                 fontSize: isSmallScreen ? 12 : 14,
//                 fontFamily: 'PolySans',
//               ),
//               onChanged: (value) => tyreData['tread'] = value,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _exportToPdf() async {
//     try {
//       final pdfBytes = await PdfExportService.generatePdf(formData);
//       await Printing.sharePdf(
//         bytes: pdfBytes,
//         filename: 'service-check-form.pdf',
//       );
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder:
//             (context) => AlertDialog(
//               title: const Text('Error'),
//               content: Text('Failed to generate PDF: $e'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('OK'),
//                 ),
//               ],
//             ),
//       );
//     }
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:data/models/service_form_model.dart';
import 'package:data/services/pdf_export_service.dart';
import 'package:data/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printing/printing.dart';

class StepController extends GetxController {
  var currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < 10) {
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

class MainFormScreen extends StatefulWidget {
  @override
  _MainFormScreenState createState() => _MainFormScreenState();
}

class _MainFormScreenState extends State<MainFormScreen> {
  final ServiceFormModel formData = ServiceFormModel();
  final _formKey = GlobalKey<FormState>();
  final List<String> statusOptions = ['P', 'F', 'N/A', 'R'];
  final StepController stepController = Get.put(StepController());

  // Image handling variables
  File? _selectedImage;
  Uint8List? _imageBytes;
  bool _isUploading = false;

  final List<String> stepTitles = [
    'Main Information',
    'Customer Info',
    'Underbody',
    'Electrical System',
    'Water System',
    'Bodywork',
    'Ventilation & Safety',
    'Gas System',
    'Tyre Information',
    'Electrical Tests',
    'Finalization',
  ];

  // Image picker method
  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 800,
      );

      if (image != null) {
        setState(() {
          _isUploading = true;
        });

        final File imageFile = File(image.path);
        final Uint8List bytes = await imageFile.readAsBytes();

        setState(() {
          _selectedImage = imageFile;
          _imageBytes = bytes;
          _isUploading = false;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      setState(() {
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Remove image method
  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _imageBytes = null;
    });
  }

  // Updated PDF export method
  void _exportToPdf() async {
    try {
      setState(() {
        _isUploading = true;
      });

      final pdfBytes = await PdfExportService.generatePdf(
        formData,
        logoImageBytes: _imageBytes,
      );

      await Printing.sharePdf(
        bytes: pdfBytes,
        filename: 'service-check-form.pdf',
      );

      setState(() {
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF generated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error generating PDF: $e');
      setState(() {
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Container(
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
                          Container(),

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
                      _buildExportButton(isSmallScreen),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportButton(bool isSmallScreen) {
    return SizedBox(
      width: double.infinity,
      child:
          _isUploading
              ? ElevatedButton(
                onPressed: null,
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
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Generating PDF...',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'PolySans',
                      ),
                    ),
                  ],
                ),
              )
              : ElevatedButton.icon(
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
    );
  }

  Widget _buildFormContainer(Widget child, bool isSmallScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 430),
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
      ),
    );
  }

  Widget _buildStepContent(int step, double width) {
    bool isSmallScreen = width < 600;

    switch (step) {
      case 0:
        return _buildMainInformationSection(isSmallScreen);
      case 1:
        return _buildCustomerInfoSection(isSmallScreen);
      case 2:
        return _buildChassisRunningGearSection(isSmallScreen);
      case 3:
        return _buildElectricalSystemSection(isSmallScreen);
      case 4:
        return _buildWaterSystemSection(isSmallScreen);
      case 5:
        return _buildBodyworkSection(isSmallScreen);
      case 6:
        return _buildVentilationSafetySection(isSmallScreen);
      case 7:
        return _buildGasSystemSection(isSmallScreen);
      case 8:
        return _buildTyreInfoSection(isSmallScreen);
      case 9:
        return _buildElectricalTestsSection(isSmallScreen);
      case 10:
        return _buildFinalizationSection(isSmallScreen);
      default:
        return Container();
    }
  }

  Widget _buildMainInformationSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Main Information',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 25),

          // Upload Box with Image Preview
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child:
                _isUploading
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 12),
                          Text(
                            "Uploading...",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontFamily: 'PolySans',
                            ),
                          ),
                        ],
                      ),
                    )
                    : InkWell(
                      onTap: _pickImage,
                      borderRadius: BorderRadius.circular(12),
                      child: Center(
                        child:
                            _selectedImage != null
                                ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        _selectedImage!,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          onPressed: _removeImage,
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(
                                            minWidth: 24,
                                            minHeight: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.attach_file,
                                          color: Colors.grey.shade600,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Add* Attachments",
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontFamily: 'PolySans',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "File Type: JPG, PNG, JPEG",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 11,
                                        fontFamily: 'PolySans',
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
          ),

          const SizedBox(height: 20),

          // Workshop Name & Address
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: isSmallScreen ? 50 : 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter* Approved Workshop Name & Address',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    isDense: true,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: isSmallScreen ? 12 : 14,
                      fontFamily: 'PolySans',
                    ),
                  ),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 14,
                    fontFamily: 'PolySans',
                  ),
                  onChanged: (value) => formData.workshopName = value,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Job Reference/Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: isSmallScreen ? 50 : 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter* Job Reference/Date',
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
                  onChanged: (value) => formData.jobReference = value,
                ),
              ),
            ],
          ),
        ],
      ),
      isSmallScreen,
    );
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

          // Customer Name
          Container(
            height: isSmallScreen ? 50 : 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter* Customer Name',
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
              onChanged: (value) => formData.customerName = value,
            ),
          ),
          const SizedBox(height: 16),

          // Make & Model
          Container(
            height: isSmallScreen ? 50 : 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter* Make & Model',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
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
              onChanged: (value) => formData.makeModel = value,
            ),
          ),
          const SizedBox(height: 16),

          // Workshop Name
          Container(
            height: isSmallScreen ? 50 : 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter* Workshop Name',
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
              onChanged: (value) => formData.workshopName = value,
            ),
          ),
          const SizedBox(height: 16),

          // Job Reference
          Container(
            height: isSmallScreen ? 50 : 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter* Job Reference',
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
              onChanged: (value) => formData.jobReference = value,
            ),
          ),
          const SizedBox(height: 16),

          // CRIS/Vin Number
          Container(
            height: isSmallScreen ? 50 : 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter* CRIS/Vin Number',
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
              onChanged: (value) => formData.crisVinNumber = value,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildChassisRunningGearSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Underbody',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 20),
          ...formData.chassisRunningGear.entries.map(
            (entry) => _buildStatusField(entry.key, entry.value, (value) {
              setState(() {
                formData.chassisRunningGear[entry.key] = value;
              });
            }, isSmallScreen),
          ),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildElectricalSystemSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Electrical System',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 20),
          ...formData.electricalSystem.entries.map(
            (entry) => _buildStatusField(entry.key, entry.value, (value) {
              setState(() {
                formData.electricalSystem[entry.key] = value;
              });
            }, isSmallScreen),
          ),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildWaterSystemSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Water System',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 20),
          ...formData.waterSystem.entries.map(
            (entry) => _buildStatusField(entry.key, entry.value, (value) {
              setState(() {
                formData.waterSystem[entry.key] = value;
              });
            }, isSmallScreen),
          ),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildBodyworkSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bodywork',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 20),
          ...formData.bodywork.entries.map(
            (entry) => _buildStatusField(entry.key, entry.value, (value) {
              setState(() {
                formData.bodywork[entry.key] = value;
              });
            }, isSmallScreen),
          ),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildVentilationSafetySection(bool isSmallScreen) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFormContainer(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ventilation',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'PolySans',
                  ),
                ),
                const SizedBox(height: 20),
                ...formData.ventilation.entries.map(
                  (entry) => _buildStatusField(entry.key, entry.value, (value) {
                    setState(() {
                      formData.ventilation[entry.key] = value;
                    });
                  }, isSmallScreen),
                ),
              ],
            ),
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildFormContainer(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fire & Safety',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'PolySans',
                  ),
                ),
                const SizedBox(height: 20),
                ...formData.fireSafety.entries.map(
                  (entry) => _buildStatusField(entry.key, entry.value, (value) {
                    setState(() {
                      formData.fireSafety[entry.key] = value;
                    });
                  }, isSmallScreen),
                ),
              ],
            ),
            isSmallScreen,
          ),
        ],
      ),
    );
  }

  Widget _buildGasSystemSection(bool isSmallScreen) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFormContainer(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LPG Gas System',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'PolySans',
                  ),
                ),
                const SizedBox(height: 20),
                ...formData.gasSystem.entries.map(
                  (entry) => _buildStatusField(entry.key, entry.value, (value) {
                    setState(() {
                      formData.gasSystem[entry.key] = value;
                    });
                  }, isSmallScreen),
                ),
              ],
            ),
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildGasDetailsSection(isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildTyreInfoSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tyre Information',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 20),
          ...formData.tyres.entries.map(
            (tyre) => _buildTyreRow(tyre.key, tyre.value, isSmallScreen),
          ),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildElectricalTestsSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Electrical Tests',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 20),
          _buildScreenshotTextField(
            'Battery Rest Voltage',
            (value) => formData.batteryRestVoltage = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildScreenshotTextField(
            'Charger Voltage',
            (value) => formData.chargerVoltage = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildScreenshotTextField(
            'RCD Test 1xI∆n',
            (value) => formData.rcdTest1x = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildScreenshotTextField(
            'RCD Test 5xI∆n',
            (value) => formData.rcdTest5x = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildScreenshotTextField(
            'Earth Bond Chassis (Ω)',
            (value) => formData.earthBondChassis = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildScreenshotTextField(
            'Earth Bond Gas (Ω)',
            (value) => formData.earthBondGas = value,
            isSmallScreen,
          ),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildGasDetailsSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gas System Details',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 20),
          _buildScreenshotTextField(
            'Gas Hose Expiry/Manufacture Date',
            (value) => formData.gasHoseExpiry = value,
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildScreenshotTextField(
            'Regulator Age',
            (value) => formData.regulatorAge = value,
            isSmallScreen,
          ),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildFinalizationSection(bool isSmallScreen) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFormContainer(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Finalization',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'PolySans',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Service Information/Additional Work',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 3,
                    onChanged: (value) => formData.serviceInfo = value,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'EICR Offered:',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontFamily: 'PolySans',
                      ),
                    ),
                    Checkbox(
                      value: formData.eicrOffered,
                      onChanged:
                          (value) => setState(
                            () => formData.eicrOffered = value ?? false,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildScreenshotTextField(
                  'Wheel Torque Setting (NM)',
                  (value) => formData.wheelTorqueSetting = value,
                  isSmallScreen,
                ),
                const SizedBox(height: 16),
                _buildScreenshotTextField(
                  'Technician Name',
                  (value) => formData.technicianName = value,
                  isSmallScreen,
                ),
                const SizedBox(height: 16),
                _buildScreenshotTextField(
                  'Double Check Name',
                  (value) => formData.doubleCheckName = value,
                  isSmallScreen,
                ),
              ],
            ),
            isSmallScreen,
          ),
          const SizedBox(height: 16),
          _buildFinalChecksSection(isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildFinalChecksSection(bool isSmallScreen) {
    return _buildFormContainer(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Final Checks',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PolySans',
            ),
          ),
          const SizedBox(height: 20),
          ...formData.finalChecks.entries.map(
            (check) => CheckboxListTile(
              title: Text(
                check.key,
                style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
              ),
              value: check.value,
              onChanged:
                  (value) => setState(
                    () => formData.finalChecks[check.key] = value ?? false,
                  ),
            ),
          ),
        ],
      ),
      isSmallScreen,
    );
  }

  Widget _buildScreenshotTextField(
    String hint,
    Function(String) onChanged,
    bool isSmallScreen,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
            fontFamily: 'PolySans',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: isSmallScreen ? 45 : 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              isDense: true,
            ),
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontFamily: 'PolySans',
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusField(
    String label,
    String value,
    Function(String) onChanged,
    bool isSmallScreen,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
                fontFamily: 'PolySans',
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Container(
              height: isSmallScreen ? 45 : 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: DropdownButtonFormField<String>(
                value: value.isEmpty ? null : value,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  isDense: true,
                ),
                items:
                    statusOptions.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(
                          status,
                          style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                        ),
                      );
                    }).toList(),
                onChanged: (newValue) => onChanged(newValue ?? ''),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTyreRow(
    String position,
    Map<String, String> tyreData,
    bool isSmallScreen,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              position,
              style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Age',
                hintText: 'Years',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: isSmallScreen ? 10 : 12,
                ),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                fontFamily: 'PolySans',
              ),
              onChanged: (value) => tyreData['age'] = value,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Pressure',
                hintText: 'PSI/BAR',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: isSmallScreen ? 10 : 12,
                ),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                fontFamily: 'PolySans',
              ),
              onChanged: (value) => tyreData['pressure'] = value,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Tread (mm)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: isSmallScreen ? 10 : 12,
                ),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                fontFamily: 'PolySans',
              ),
              onChanged: (value) => tyreData['tread'] = value,
            ),
          ),
        ],
      ),
    );
  }
}
