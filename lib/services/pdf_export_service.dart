// import 'dart:typed_data';
// import 'package:data/models/service_form_model.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:intl/intl.dart';

// class PdfExportService {
//   static Future<Uint8List> generatePdf(ServiceFormModel formData) async {
//     final pdf = pw.Document();

//     // Load logo image (replace with your actual image loading logic)
//     final logoImage = await _loadLogoImage();

//     // Add first page
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               _buildHeader(formData, logoImage),
//               pw.SizedBox(height: 20),
//               _buildChassisRunningGearTable(formData),
//               pw.SizedBox(height: 10),
//               _buildElectricalSystemTable(formData),
//               pw.SizedBox(height: 10),
//               _buildWaterSystemTable(formData),
//               pw.SizedBox(height: 10),
//               _buildBodyworkTable(formData),
//             ],
//           );
//         },
//       ),
//     );

//     // Add second page
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               _build2Header(formData, logoImage),
//               _buildVentilationTable(formData),
//               pw.SizedBox(height: 10),
//               _buildFireSafetyTable(formData),
//               pw.SizedBox(height: 10),
//               _buildGasSystemTable(formData),
//               pw.SizedBox(height: 10),
//               _buildTyreInfoTable(formData),
//               pw.SizedBox(height: 10),
//               _buildFinalizationSection(formData),
//               pw.SizedBox(height: 10),
//               _buildFinalChecksSection(formData),
//             ],
//           );
//         },
//       ),
//     );

//     return pdf.save();
//   }

//   static pw.Widget _buildHeader(
//     ServiceFormModel formData,
//     pw.MemoryImage? logoImage,
//   ) {
//     return pw.Column(
//       children: [
//         // Header row with logo, title, and right grey container
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             // Left: Logo image
//             logoImage != null
//                 ? pw.Container(
//                   width: 80,
//                   height: 40,
//                   child: pw.Image(logoImage),
//                 )
//                 : pw.Container(
//                   width: 80,
//                   height: 40,
//                   color: PdfColors.grey200,
//                   child: pw.Center(
//                     child: pw.Text(
//                       'LOGO',
//                       style: pw.TextStyle(
//                         fontSize: 8,
//                         color: PdfColors.grey600,
//                       ),
//                     ),
//                   ),
//                 ),

//             // Center: Title section
//             pw.Expanded(
//               child: pw.Container(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 10),
//                 child: pw.Column(
//                   mainAxisAlignment: pw.MainAxisAlignment.center,
//                   children: [
//                     pw.Text(
//                       'Tourer Annual Service Check Sheet',
//                       style: pw.TextStyle(
//                         fontSize: 10,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                       textAlign: pw.TextAlign.center,
//                     ),
//                     pw.SizedBox(height: 4),
//                     pw.Text(
//                       'Wheel bolt torque should be re-checked after 30 miles and before EVERY TRIP',
//                       style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 13,
//                         color: PdfColors.red, // Red color as requested
//                       ),
//                       textAlign: pw.TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             pw.Container(
//               width: 120,
//               height: 50,
//               color: PdfColor.fromInt(0xFFF5F5F5),
//               padding: const pw.EdgeInsets.all(10.0),
//               child: pw.Column(
//                 mainAxisAlignment: pw.MainAxisAlignment.center,
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     'Approved Workshop',
//                     style: pw.TextStyle(fontSize: 6),
//                   ),
//                   pw.SizedBox(height: 3),
//                   pw.Text(
//                     'Approved Workshop Name & Address',
//                     style: pw.TextStyle(fontSize: 5),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         pw.SizedBox(height: 16),

//         // Job reference and date section
//         pw.Container(
//           decoration: pw.BoxDecoration(
//             border: pw.Border.all(color: PdfColors.black, width: 1),
//           ),
//           padding: const pw.EdgeInsets.all(8.0),
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Row(
//                 children: [
//                   pw.Expanded(
//                     child: pw.Text(
//                       'Job Reference/Date: ${formData.jobReference}',
//                       style: pw.TextStyle(fontSize: 10),
//                     ),
//                   ),
//                   pw.Expanded(
//                     child: pw.Text(
//                       'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
//                       style: pw.TextStyle(fontSize: 10),
//                     ),
//                   ),
//                 ],
//               ),
//               pw.SizedBox(height: 6),
//               pw.Text(
//                 'Customer Name: ${formData.customerName}',
//                 style: pw.TextStyle(fontSize: 10),
//               ),
//               pw.Text(
//                 'Make & Model: ${formData.makeModel}',
//                 style: pw.TextStyle(fontSize: 10),
//               ),
//               pw.Text(
//                 'CRIS/Vin Number: ${formData.crisVinNumber}',
//                 style: pw.TextStyle(fontSize: 10),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Helper function to load logo image (replace with your actual implementation)
//   static Future<pw.MemoryImage?> _loadLogoImage() async {
//     try {
//       final byteData = await rootBundle.load('assets/images/logoimg.png');
//       final Uint8List imageBytes = byteData.buffer.asUint8List();
//       return pw.MemoryImage(imageBytes);
//     } catch (e) {
//       print('Error loading logo image: $e');
//       return null;
//     }
//   }

//   // Keep all your existing table methods unchanged below...
//   static pw.Widget _buildChassisRunningGearTable(ServiceFormModel formData) {
//     return pw.Table(
//       border: pw.TableBorder.all(),
//       children: [
//         pw.TableRow(
//           children: [
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Chassis & Running Gear',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Status',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//         for (var entry in formData.chassisRunningGear.entries)
//           pw.TableRow(
//             children: [
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.key),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.value.isEmpty ? '-' : entry.value),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   static pw.Widget _buildElectricalSystemTable(ServiceFormModel formData) {
//     return pw.Table(
//       border: pw.TableBorder.all(),
//       children: [
//         pw.TableRow(
//           children: [
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Electrical System',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Status',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//         for (var entry in formData.electricalSystem.entries)
//           pw.TableRow(
//             children: [
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.key),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.value.isEmpty ? '-' : entry.value),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   static pw.Widget _buildWaterSystemTable(ServiceFormModel formData) {
//     return pw.Table(
//       border: pw.TableBorder.all(),
//       children: [
//         pw.TableRow(
//           children: [
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Water System',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Status',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//         for (var entry in formData.waterSystem.entries)
//           pw.TableRow(
//             children: [
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.key),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.value.isEmpty ? '-' : entry.value),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   static pw.Widget _buildBodyworkTable(ServiceFormModel formData) {
//     return pw.Table(
//       border: pw.TableBorder.all(),
//       children: [
//         pw.TableRow(
//           children: [
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Bodywork',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Status',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//         for (var entry in formData.bodywork.entries)
//           pw.TableRow(
//             children: [
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.key),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.value.isEmpty ? '-' : entry.value),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   static pw.Widget _build2Header(
//     ServiceFormModel formData,
//     pw.MemoryImage? logoImage,
//   ) {
//     return pw.Column(
//       children: [
//         // Header row with logo, title, and right grey container
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             // Left: Logo image
//             logoImage != null
//                 ? pw.Container(
//                   width: 80,
//                   height: 40,
//                   child: pw.Image(logoImage),
//                 )
//                 : pw.Container(
//                   width: 80,
//                   height: 40,
//                   color: PdfColors.grey200,
//                   child: pw.Center(
//                     child: pw.Text(
//                       'LOGO',
//                       style: pw.TextStyle(
//                         fontSize: 8,
//                         color: PdfColors.grey600,
//                       ),
//                     ),
//                   ),
//                 ),

//             // Center: Title section
//             pw.Expanded(
//               child: pw.Container(
//                 padding: const pw.EdgeInsets.symmetric(horizontal: 10),
//                 child: pw.Column(
//                   mainAxisAlignment: pw.MainAxisAlignment.center,
//                   children: [
//                     pw.Text(
//                       'Tourer Annual Service Check Sheet',
//                       style: pw.TextStyle(
//                         fontSize: 10,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                       textAlign: pw.TextAlign.center,
//                     ),
//                     pw.SizedBox(height: 4),
//                     pw.Text(
//                       'Wheel bolt torque should be re-checked after 30 miles and before EVERY TRIP',
//                       style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 13,
//                         color: PdfColors.red, // Red color as requested
//                       ),
//                       textAlign: pw.TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             pw.Container(
//               width: 120,
//               height: 50,
//               color: PdfColor.fromInt(0xFFF5F5F5),
//               padding: const pw.EdgeInsets.all(10.0),
//               child: pw.Column(
//                 mainAxisAlignment: pw.MainAxisAlignment.center,
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     'Approved Workshop',
//                     style: pw.TextStyle(fontSize: 6),
//                   ),
//                   pw.SizedBox(height: 3),
//                   pw.Text(
//                     'Approved Workshop Name & Address',
//                     style: pw.TextStyle(fontSize: 5),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),

//         pw.SizedBox(height: 16),

//         // Job reference and date section
//         pw.Container(
//           decoration: pw.BoxDecoration(
//             border: pw.Border.all(color: PdfColors.black, width: 1),
//           ),
//           padding: const pw.EdgeInsets.all(8.0),
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Row(
//                 children: [
//                   pw.Expanded(
//                     child: pw.Text(
//                       'Job Reference/Date: ${formData.jobReference}',
//                       style: pw.TextStyle(fontSize: 10),
//                     ),
//                   ),
//                   pw.Expanded(
//                     child: pw.Text(
//                       'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
//                       style: pw.TextStyle(fontSize: 10),
//                     ),
//                   ),
//                 ],
//               ),
//               pw.SizedBox(height: 6),
//               pw.Text(
//                 'Customer Name: ${formData.customerName}',
//                 style: pw.TextStyle(fontSize: 10),
//               ),
//               pw.Text(
//                 'Make & Model: ${formData.makeModel}',
//                 style: pw.TextStyle(fontSize: 10),
//               ),
//               pw.Text(
//                 'CRIS/Vin Number: ${formData.crisVinNumber}',
//                 style: pw.TextStyle(fontSize: 10),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   static pw.Widget _buildVentilationTable(ServiceFormModel formData) {
//     return pw.Table(
//       border: pw.TableBorder.all(),
//       children: [
//         pw.TableRow(
//           children: [
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Ventilation',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Status',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//         for (var entry in formData.ventilation.entries)
//           pw.TableRow(
//             children: [
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.key),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.value.isEmpty ? '-' : entry.value),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   static pw.Widget _buildFireSafetyTable(ServiceFormModel formData) {
//     return pw.Table(
//       border: pw.TableBorder.all(),
//       children: [
//         pw.TableRow(
//           children: [
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Fire & Safety',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Status',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//         for (var entry in formData.fireSafety.entries)
//           pw.TableRow(
//             children: [
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.key),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.value.isEmpty ? '-' : entry.value),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   static pw.Widget _buildGasSystemTable(ServiceFormModel formData) {
//     return pw.Table(
//       border: pw.TableBorder.all(),
//       children: [
//         pw.TableRow(
//           children: [
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'LPG Gas System',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Status',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//         for (var entry in formData.gasSystem.entries)
//           pw.TableRow(
//             children: [
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.key),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.value.isEmpty ? '-' : entry.value),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   static pw.Widget _buildTyreInfoTable(ServiceFormModel formData) {
//     return pw.Table(
//       border: pw.TableBorder.all(),
//       children: [
//         pw.TableRow(
//           children: [
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Position',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Age',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Pressure',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//             pw.Padding(
//               padding: const pw.EdgeInsets.all(4.0),
//               child: pw.Text(
//                 'Tread (mm)',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//         for (var entry in formData.tyres.entries)
//           pw.TableRow(
//             children: [
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(entry.key),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(
//                   entry.value['age']?.isEmpty ?? true
//                       ? '-'
//                       : entry.value['age']!,
//                 ),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(
//                   entry.value['pressure']?.isEmpty ?? true
//                       ? '-'
//                       : entry.value['pressure']!,
//                 ),
//               ),
//               pw.Padding(
//                 padding: const pw.EdgeInsets.all(4.0),
//                 child: pw.Text(
//                   entry.value['tread']?.isEmpty ?? true
//                       ? '-'
//                       : entry.value['tread']!,
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   static pw.Widget _buildFinalizationSection(ServiceFormModel formData) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(
//           'Service Finalization',
//           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 5),
//         pw.Text(
//           'Service Information/Additional Work: ${formData.serviceInfo.isEmpty ? 'N/A' : formData.serviceInfo}',
//         ),
//         pw.Text('EICR Offered: ${formData.eicrOffered ? 'Yes' : 'No'}'),
//         pw.Text(
//           'Wheel Bolt Torque Setting: ${formData.wheelTorqueSetting.isEmpty ? 'N/A' : '${formData.wheelTorqueSetting} NM'}',
//         ),
//         pw.Text(
//           'Technician Name: ${formData.technicianName.isEmpty ? 'N/A' : formData.technicianName}',
//         ),
//         pw.Text(
//           'Double Check Signature: ${formData.doubleCheckName.isEmpty ? 'N/A' : formData.doubleCheckName}',
//         ),
//         pw.SizedBox(height: 10),
//         pw.Text(
//           'Electrical Tests',
//           style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.Text(
//           'Battery Rest Voltage: ${formData.batteryRestVoltage.isEmpty ? 'N/A' : formData.batteryRestVoltage}',
//         ),
//         pw.Text(
//           'Charger Voltage: ${formData.chargerVoltage.isEmpty ? 'N/A' : formData.chargerVoltage}',
//         ),
//         pw.Text(
//           'RCD Test 1xI∆n: ${formData.rcdTest1x.isEmpty ? 'N/A' : formData.rcdTest1x}',
//         ),
//         pw.Text(
//           'RCD Test 5xI∆n: ${formData.rcdTest5x.isEmpty ? 'N/A' : formData.rcdTest5x}',
//         ),
//         pw.Text(
//           'Earth Bond Chassis: ${formData.earthBondChassis.isEmpty ? 'N/A' : formData.earthBondChassis} Ω',
//         ),
//         pw.Text(
//           'Earth Bond Gas: ${formData.earthBondGas.isEmpty ? 'N/A' : formData.earthBondGas} Ω',
//         ),
//         pw.SizedBox(height: 10),
//         pw.Text(
//           'Gas Hose Expiry: ${formData.gasHoseExpiry.isEmpty ? 'N/A' : formData.gasHoseExpiry}',
//         ),
//         pw.Text(
//           'Regulator Age: ${formData.regulatorAge.isEmpty ? 'N/A' : formData.regulatorAge}',
//         ),
//       ],
//     );
//   }

//   static pw.Widget _buildFinalChecksSection(ServiceFormModel formData) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(
//           'Final Checks',
//           style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 5),
//         for (var entry in formData.finalChecks.entries)
//           pw.Row(
//             children: [
//               pw.Text('☐', style: pw.TextStyle(fontSize: 12)),
//               pw.SizedBox(width: 5),
//               pw.Text(entry.key, style: pw.TextStyle(fontSize: 10)),
//               pw.SizedBox(width: 10),
//               pw.Text(
//                 entry.value ? '✓ Completed' : '□ Not Completed',
//                 style: pw.TextStyle(fontSize: 10),
//               ),
//             ],
//           ),
//         pw.SizedBox(height: 10),
//         pw.Text(
//           'Note: This service report only relates to the condition of the above-mentioned tourer at the time of completion of the service. It should not be regarded as evidence of the condition of the items at any other time.',
//           style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
//         ),
//       ],
//     );
//   }
// }
import 'dart:typed_data';
import 'package:data/models/service_form_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class PdfExportService {
  static Future<Uint8List> generatePdf(
    ServiceFormModel formData, {
    Uint8List? logoImageBytes,
  }) async {
    final pdf = pw.Document();

    // Load logo image
    final logoImage =
        logoImageBytes != null
            ? pw.MemoryImage(logoImageBytes)
            : await _loadDefaultLogoImage();

    // Add first page with ALL sections
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(formData, logoImage),
              pw.SizedBox(height: 10),

              // First Row: Underbody and Water System (flex: 2)
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildUnderbodySection(formData)),
                  pw.SizedBox(width: 10),
                  pw.Expanded(child: _buildWaterSystemSection(formData)),
                ],
              ),
              // pw.SizedBox(height: 10),

              // Second Row: Electrical System and Bodywork (flex: 1 - smaller)
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Flexible(
                    flex: 1, // Smaller flex factor
                    child: _buildElectricalSystemSection(formData),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Flexible(
                    flex: 1, // Smaller flex factor
                    child: pw.Column(
                      children: [
                        _buildBodyworkSection(formData),
                        _buildVentilationSection(formData),
                      ],
                    ),
                  ),
                ],
              ),
              // pw.SizedBox(height: 10),

              // pw.Row(
              //   crossAxisAlignment: pw.CrossAxisAlignment.start,
              //   children: [
              //     pw.Expanded(child: _buildLpgGasSystemSection(formData)),
              //     pw.SizedBox(width: 10),
              //     pw.Expanded(child: _buildFireSafetySection(formData)),
              //   ],
              // ),
              // pw.SizedBox(height: 10),
              // _buildPageFooter(1),
            ],
          );
        },
      ),
    ); // Add second page

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildLpgGasSystemSection(formData)),
                  pw.SizedBox(width: 10),
                  pw.Expanded(child: _buildFireSafetySection(formData)),
                ],
              ),
              _buildServiceInformationSection(formData),
              _buildPageFooter(1),
            ],
          );
        },
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(formData, logoImage), // Same header as page 1
              // pw.SizedBox(height: 10),
              // _buildServiceInformationSection(formData),
              //pw.SizedBox(height: 10),
              // _buildTyreInfoSection(formData),
              // pw.SizedBox(height: 10),
              // _buildElectricalTestsSection(formData),
              pw.SizedBox(height: 10),
              _buildFinalChecksSection(formData),
              pw.SizedBox(height: 10),
              _buildSignaturesSection(formData),
              pw.SizedBox(height: 10),
              _buildPageFooter(2), // Same footer style but with page number 2
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  static Future<pw.MemoryImage?> _loadDefaultLogoImage() async {
    try {
      final byteData = await rootBundle.load('assets/images/logoimg.png');
      final Uint8List imageBytes = byteData.buffer.asUint8List();
      return pw.MemoryImage(imageBytes);
    } catch (e) {
      print('Error loading default logo image: $e');
      return null;
    }
  }

  static pw.Widget _buildHeader(
    ServiceFormModel formData,
    pw.ImageProvider? logoImage,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Logo and Title Row
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            if (logoImage != null)
              pw.Container(width: 100, height: 50, child: pw.Image(logoImage))
            else
              pw.Container(
                width: 100,
                height: 50,
                child: pw.Text('No Logo', style: pw.TextStyle(fontSize: 9)),
              ),

            // Title
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Text(
                    'Tourer Annual Habitation Service Check Sheet',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'All work must be carried out in accordance with the latest AWS Standard Working Procedures',
                    style: pw.TextStyle(fontSize: 9),
                    textAlign: pw.TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'Service Technician: Please ensure that every question is answered correctly using: P (pass), F (fail), N/A (not applicable) & R (rectified)',
          style: pw.TextStyle(fontSize: 9),
        ),
        pw.SizedBox(height: 10),

        // Workshop info
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Approved Workshop Name & Address',
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Container(
                    height: 15,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 0.5),
                    ),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 4),
                      child: pw.Text(
                        formData.workshopName.isNotEmpty
                            ? formData.workshopName
                            : 'Not provided',
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(width: 20),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Job Reference/Date',
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Container(
                    height: 15,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 0.5),
                    ),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 4),
                      child: pw.Text(
                        formData.jobReference.isNotEmpty
                            ? formData.jobReference
                            : 'Not provided',
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 8),

        // Customer info table
        pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1),
          },
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Customer Name',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Make & Model',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'CRIS/Vin Number',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    formData.customerName.isNotEmpty
                        ? formData.customerName
                        : 'Not provided',
                    style: pw.TextStyle(fontSize: 9),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    formData.makeModel.isNotEmpty
                        ? formData.makeModel
                        : 'Not provided',
                    style: pw.TextStyle(fontSize: 9),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    formData.crisVinNumber.isNotEmpty
                        ? formData.crisVinNumber
                        : 'Not provided',
                    style: pw.TextStyle(fontSize: 9),
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Divider(thickness: 1),
      ],
    );
  }

  static pw.Widget _buildUnderbodySection(ServiceFormModel formData) {
    return _buildSectionWithCheckboxes(
      'Underbody',
      formData.chassisRunningGear.keys.toList(),
      formData.chassisRunningGear,
    );
  }

  static pw.Widget _buildElectricalSystemSection(ServiceFormModel formData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionWithCheckboxes(
          'Electrical System',
          formData.electricalSystem.keys.toList(),
          formData.electricalSystem,
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          height: 15,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 0.5),
          ),
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 4),
            child: pw.Text(
              'Testing Service Technician Name: ${formData.technicianName.isNotEmpty ? formData.technicianName : 'Not provided'}',
              style: pw.TextStyle(fontSize: 9),
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildLpgGasSystemSection(ServiceFormModel formData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionWithCheckboxes(
          'LPG Gas System\n(gas appliances not serviced unless requested)',
          formData.gasSystem.keys.toList(),
          formData.gasSystem,
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          height: 15,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 0.5),
          ),
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 4),
            child: pw.Text(
              'Testing Service Technicians Name: ${formData.technicianName.isNotEmpty ? formData.technicianName : 'Not provided'}',
              style: pw.TextStyle(fontSize: 9),
            ),
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'Important – All appliances are tested for operation only. This does not confirm that they are working to the prescribed standard. Additional servicing may be required for warranty purposes/products (e.g. fridge)',
          style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
        ),
        pw.SizedBox(height: 8),
        pw.Divider(thickness: 1),
      ],
    );
  }

  static pw.Widget _buildWaterSystemSection(ServiceFormModel formData) {
    return _buildSectionWithCheckboxes(
      'Water System',
      formData.waterSystem.keys.toList(),
      formData.waterSystem,
    );
  }

  static pw.Widget _buildBodyworkSection(ServiceFormModel formData) {
    return _buildSectionWithCheckboxes(
      'Bodywork',
      formData.bodywork.keys.toList(),
      formData.bodywork,
    );
  }

  static pw.Widget _buildVentilationSection(ServiceFormModel formData) {
    return _buildSectionWithCheckboxes(
      'Ventilation',
      formData.ventilation.keys.toList(),
      formData.ventilation,
    );
  }

  static pw.Widget _buildFireSafetySection(ServiceFormModel formData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionWithCheckboxes('Fire & Safety', [
          'Smoke alarm test',
          'CO alarm test',
          'Fire extinguisher security',
        ], formData.fireSafety),
        pw.SizedBox(height: 8),
        pw.Text(
          'Smoke and/or carbon monoxide alarm(s) if fitted:',
          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Smoke alarm expiry date',
                    style: pw.TextStyle(fontSize: 9),
                  ),
                  pw.Text(
                    '(if visible)',
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontStyle: pw.FontStyle.italic,
                    ),
                  ),
                  pw.Container(
                    height: 15,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 0.5),
                    ),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 4),
                      child: pw.Text(
                        formData
                                    .fireSafety['Smoke alarm expiry date']
                                    ?.isNotEmpty ==
                                true
                            ? formData.fireSafety['Smoke alarm expiry date']!
                            : 'Not provided',
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Carbon monoxide alarm expiry date',
                    style: pw.TextStyle(fontSize: 9),
                  ),
                  pw.Text(
                    '(if visible)',
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontStyle: pw.FontStyle.italic,
                    ),
                  ),
                  pw.Container(
                    height: 15,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 0.5),
                    ),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 4),
                      child: pw.Text(
                        formData
                                    .fireSafety['Carbon monoxide alarm expiry date']
                                    ?.isNotEmpty ==
                                true
                            ? formData
                                .fireSafety['Carbon monoxide alarm expiry date']!
                            : 'Not provided',
                        style: pw.TextStyle(fontSize: 9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSectionWithCheckboxes(
    String title,
    List<String> items,
    Map<String, String> formData,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(0.5),
            2: const pw.FlexColumnWidth(0.5),
            3: const pw.FlexColumnWidth(0.5),
            4: const pw.FlexColumnWidth(0.5),
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    '',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'P',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'F',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'N/A',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'R',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Item rows
            for (var item in items)
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Text(item, style: pw.TextStyle(fontSize: 9)),
                  ),
                  _buildCheckboxCell(formData[item] == 'P'),
                  _buildCheckboxCell(formData[item] == 'F'),
                  _buildCheckboxCell(formData[item] == 'N/A'),
                  _buildCheckboxCell(formData[item] == 'R'),
                ],
              ),
          ],
        ),
        pw.SizedBox(height: 8),
      ],
    );
  }

  static pw.Widget _buildCheckboxCell(bool isChecked) {
    return pw.Container(
      alignment: pw.Alignment.center,
      child: pw.Container(
        width: 10,
        height: 10,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black, width: 0.5),
          color: isChecked ? PdfColors.black : PdfColors.white,
        ),
      ),
    );
  }

  static pw.Widget _buildPageFooter(int pageNumber) {
    return pw.Container(
      width: double.infinity,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Part $pageNumber of 2', style: pw.TextStyle(fontSize: 9)),
          pw.Text('V8.31', style: pw.TextStyle(fontSize: 9)),
        ],
      ),
    );
  }

  static pw.Widget _buildSecondPageHeader(
    ServiceFormModel formData,
    pw.ImageProvider? logoImage,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Logo and Title Row
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            if (logoImage != null)
              pw.Container(width: 100, height: 50, child: pw.Image(logoImage))
            else
              pw.Container(
                width: 100,
                height: 50,
                child: pw.Text('No Logo', style: pw.TextStyle(fontSize: 9)),
              ),

            // Title
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Text(
                    'Tourer Annual Habitation Service\nFinalisation and Observation Report',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'All work must be carried out in accordance with the latest AWS Standard Working Procedures',
                    style: pw.TextStyle(fontSize: 9),
                    textAlign: pw.TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),

        // Workshop info
        pw.Container(
          height: 15,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 0.5),
          ),
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 4),
            child: pw.Text(
              formData.workshopName.isNotEmpty
                  ? formData.workshopName
                  : 'Approved Workshop Name & Address - Not provided',
              style: pw.TextStyle(fontSize: 9),
            ),
          ),
        ),
        pw.SizedBox(height: 10),

        // Customer info
        pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1),
          },
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Customer Name',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Make & Model',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'CRIS/Vin Number',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    formData.customerName.isNotEmpty
                        ? formData.customerName
                        : 'Not provided',
                    style: pw.TextStyle(fontSize: 9),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    formData.makeModel.isNotEmpty
                        ? formData.makeModel
                        : 'Not provided',
                    style: pw.TextStyle(fontSize: 9),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    formData.crisVinNumber.isNotEmpty
                        ? formData.crisVinNumber
                        : 'Not provided',
                    style: pw.TextStyle(fontSize: 9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildServiceInformationSection(ServiceFormModel formData) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(1),
      },
      children: [
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'Service Information/Additional Work & Observations',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'Repaired',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        for (int i = 0; i < 16; i++)
          pw.TableRow(
            children: [
              pw.Container(
                height: 20,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    i == 0 && formData.serviceInfo.isNotEmpty
                        ? formData.serviceInfo
                        : i == 0
                        ? 'No service information provided'
                        : ' ',
                    style: pw.TextStyle(fontSize: 9),
                  ),
                ),
              ),
              pw.Container(
                height: 20,
                child: pw.Container(), // Empty checkbox area
              ),
            ],
          ),
      ],
    );
  }

  static pw.Widget _buildTyreInfoSection(ServiceFormModel formData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Tyre Information',
          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1),
            3: const pw.FlexColumnWidth(1),
          },
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Position',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Age',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Pressure',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Tread (mm)',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            for (var entry in formData.tyres.entries)
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Text(entry.key, style: pw.TextStyle(fontSize: 9)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Text(
                      entry.value['age']?.isNotEmpty == true
                          ? entry.value['age']!
                          : 'Not provided',
                      style: pw.TextStyle(fontSize: 9),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Text(
                      entry.value['pressure']?.isNotEmpty == true
                          ? entry.value['pressure']!
                          : 'Not provided',
                      style: pw.TextStyle(fontSize: 9),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Text(
                      entry.value['tread']?.isNotEmpty == true
                          ? entry.value['tread']!
                          : 'Not provided',
                      style: pw.TextStyle(fontSize: 9),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildElectricalTestsSection(ServiceFormModel formData) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(1),
      },
      children: [
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'Electrical Tests',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'Results',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'Battery rest voltage',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                formData.batteryRestVoltage.isNotEmpty
                    ? formData.batteryRestVoltage
                    : 'Not provided',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'Charger voltage',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                formData.chargerVoltage.isNotEmpty
                    ? formData.chargerVoltage
                    : 'Not provided',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'RCD Test 1xI∆n',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                formData.rcdTest1x.isNotEmpty
                    ? formData.rcdTest1x
                    : 'Not provided',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'RCD Test 5xI∆n',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                formData.rcdTest5x.isNotEmpty
                    ? formData.rcdTest5x
                    : 'Not provided',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'Earth Bond Chassis',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                formData.earthBondChassis.isNotEmpty
                    ? '${formData.earthBondChassis} Ω'
                    : 'Not provided',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'Earth Bond Gas',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                formData.earthBondGas.isNotEmpty
                    ? '${formData.earthBondGas} Ω'
                    : 'Not provided',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                'Gas Hose Expiry',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                formData.gasHoseExpiry.isNotEmpty
                    ? formData.gasHoseExpiry
                    : 'Not provided',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text('Regulator Age', style: pw.TextStyle(fontSize: 9)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4.0),
              child: pw.Text(
                formData.regulatorAge.isNotEmpty
                    ? formData.regulatorAge
                    : 'Not provided',
                style: pw.TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildFinalChecksSection(ServiceFormModel formData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Text('EICR Offered', style: pw.TextStyle(fontSize: 9)),
            pw.SizedBox(width: 10),
            pw.Text(
              formData.eicrOffered ? 'Yes' : 'No / N/A',
              style: pw.TextStyle(fontSize: 9),
            ),
          ],
        ),
        pw.SizedBox(height: 10),

        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Left column
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < 6 && i < formData.finalChecks.length; i++)
                    _buildFinalCheckbox(
                      formData.finalChecks.keys.toList()[i],
                      formData.finalChecks.values.toList()[i],
                    ),
                ],
              ),
            ),
            // Right column
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  for (int i = 6; i < formData.finalChecks.length; i++)
                    _buildFinalCheckbox(
                      formData.finalChecks.keys.toList()[i],
                      formData.finalChecks.values.toList()[i],
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildFinalCheckbox(String text, bool isChecked) {
    return pw.Row(
      children: [
        pw.Container(
          width: 10,
          height: 10,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 0.5),
            color: isChecked ? PdfColors.black : PdfColors.white,
          ),
        ),
        pw.SizedBox(width: 4),
        pw.Text(text, style: pw.TextStyle(fontSize: 9)),
      ],
    );
  }

  static pw.Widget _buildSignaturesSection(ServiceFormModel formData) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Service Technician Name',
              style: pw.TextStyle(fontSize: 9),
            ),
            pw.Container(
              width: 150,
              height: 15,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(left: 4),
                child: pw.Text(
                  formData.technicianName.isNotEmpty
                      ? formData.technicianName
                      : 'Not provided',
                  style: pw.TextStyle(fontSize: 9),
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Signature', style: pw.TextStyle(fontSize: 9)),
            pw.Container(
              width: 150,
              height: 30,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Customer Signature', style: pw.TextStyle(fontSize: 9)),
            pw.Container(
              width: 150,
              height: 30,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text('Date', style: pw.TextStyle(fontSize: 9)),
            pw.Container(
              width: 150,
              height: 15,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black, width: 0.5),
              ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(left: 4),
                child: pw.Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.now()),
                  style: pw.TextStyle(fontSize: 9),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSecondPageFooter() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 10),
        pw.Text(
          'This service report only relates to the condition of the above-mentioned tourer at the time of completion of the service. It should not be regarded as evidence of the condition of the items at any other time.',
          style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          'Important – Appliances are checked for operation only; additional servicing may be required for warranty purposes.',
          style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          'The habitation service does not include servicing of the base vehicle and road legal requirements',
          style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          'Your feedback is important to the scheme, please take a few minutes to login to www.approveworkshops.co.uk and complete the customer satisfaction survey. Thank you.',
          style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Part 2 of 2', style: pw.TextStyle(fontSize: 9)),
            pw.Text('DNL50925    V8.31', style: pw.TextStyle(fontSize: 9)),
          ],
        ),
      ],
    );
  }
}
