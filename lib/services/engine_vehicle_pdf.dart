// // engine_vehicle_pdf.dart
// import 'dart:typed_data';
// import 'package:data/models/engine_vehicle_model.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:intl/intl.dart';

// class EngineVehiclePdfService {
//   static Future<Uint8List> generatePdf(
//     EngineVehicleModel formData, {
//     Uint8List? logoImageBytes,
//   }) async {
//     final pdf = pw.Document();

//     // Load logo image
//     final logoImage =
//         logoImageBytes != null
//             ? pw.MemoryImage(logoImageBytes)
//             : await _loadDefaultLogoImage();

//     // Add first page with ALL sections
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               _buildHeader(formData, logoImage),
//               pw.SizedBox(height: 10),

//               // First Row: Parts Included and Top-ups Included
//               pw.Row(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Expanded(child: _buildPartsIncludedSection(formData)),
//                   pw.SizedBox(width: 10),
//                   pw.Expanded(child: _buildTopupsIncludedSection(formData)),
//                 ],
//               ),
//               pw.SizedBox(height: 10),

//               // Second Row: General Checks and Internal/Vision
//               pw.Row(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Expanded(child: _buildGeneralChecksSection(formData)),
//                   pw.SizedBox(width: 10),
//                   pw.Expanded(child: _buildInternalVisionSection(formData)),
//                 ],
//               ),
//               pw.SizedBox(height: 10),

//               // Third Row: Engine and Brake
//               pw.Row(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Expanded(child: _buildEngineSection(formData)),
//                   pw.SizedBox(width: 10),
//                   pw.Expanded(child: _buildBrakeSection(formData)),
//                 ],
//               ),
//               pw.SizedBox(height: 10),
//               // _buildPageFooter(1),
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
//               _buildHeader(formData, logoImage),
//               pw.SizedBox(height: 10),

//               // First Row: Wheels & Tyres and Steering & Suspension
//               pw.Row(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Expanded(child: _buildWheelsTyresSection(formData)),
//                   pw.SizedBox(width: 10),
//                   pw.Expanded(child: _buildSteeringSuspensionSection(formData)),
//                 ],
//               ),
//               pw.SizedBox(height: 10),

//               // Second Row: Exhaust and Drive System
//               pw.Row(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Expanded(child: _buildExhaustSection(formData)),
//                   pw.SizedBox(width: 10),
//                   pw.Expanded(child: _buildDriveSystemSection(formData)),
//                 ],
//               ),
//               pw.SizedBox(height: 10),
//               _buildCommentsSection(formData),
//               pw.SizedBox(height: 10),
//               // _buildPageFooter(2),
//             ],
//           );
//         },
//       ),
//     );

//     return pdf.save();
//   }

//   static pw.Widget _buildHeader(
//     EngineVehicleModel formData,
//     pw.ImageProvider? logoImage,
//   ) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         // Logo and Title Row
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             // Logo
//             if (logoImage != null)
//               pw.Container(width: 100, height: 50, child: pw.Image(logoImage))
//             else
//               pw.Container(
//                 width: 100,
//                 height: 50,
//                 child: pw.Text('LOGO', style: pw.TextStyle(fontSize: 9)),
//               ),

//             // Title
//             pw.Expanded(
//               child: pw.Column(
//                 children: [
//                   pw.Text(
//                     'Engine Vehicle Service Form',
//                     style: pw.TextStyle(
//                       fontSize: 16,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     textAlign: pw.TextAlign.center,
//                   ),
//                   pw.SizedBox(height: 8),
//                   pw.Text(
//                     'Professional Vehicle Maintenance Record',
//                     style: pw.TextStyle(fontSize: 9),
//                     textAlign: pw.TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         pw.SizedBox(height: 8),
//         pw.Text(
//           'Service Technician: Please ensure that every question is answered correctly using: P (pass), F (fail), N/A (not applicable) & R (rectified)',
//           style: pw.TextStyle(fontSize: 9),
//         ),
//         pw.SizedBox(height: 10),

//         // Workshop info
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Expanded(
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     'Approved Workshop Name & Address',
//                     style: pw.TextStyle(
//                       fontSize: 10,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                   pw.Container(
//                     height: 15,
//                     child: pw.Padding(
//                       padding: const pw.EdgeInsets.only(left: 4),
//                       child: pw.Text(
//                         formData.workshopName.isNotEmpty
//                             ? formData.workshopName
//                             : 'Not provided',
//                         style: pw.TextStyle(fontSize: 9),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             pw.SizedBox(width: 20),
//             pw.Expanded(
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Text(
//                     'Job Reference/Date',
//                     style: pw.TextStyle(
//                       fontSize: 10,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                   pw.Container(
//                     height: 15,
//                     child: pw.Padding(
//                       padding: const pw.EdgeInsets.only(left: 4),
//                       child: pw.Text(
//                         '${formData.jobReference.isNotEmpty ? formData.jobReference : 'Not provided'} / ${DateFormat('yyyy-MM-dd').format(formData.serviceDate ?? DateTime.now())}',
//                         style: pw.TextStyle(fontSize: 9),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         pw.SizedBox(height: 8),

//         // Customer info table
//         pw.Table(
//           border: pw.TableBorder.all(width: 0.5),
//           columnWidths: {
//             0: const pw.FlexColumnWidth(1),
//             1: const pw.FlexColumnWidth(1),
//             2: const pw.FlexColumnWidth(1),
//           },
//           children: [
//             pw.TableRow(
//               decoration: pw.BoxDecoration(color: PdfColors.grey300),
//               children: [
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Text(
//                     'Customer Name',
//                     style: pw.TextStyle(
//                       fontSize: 9,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Text(
//                     'Make & Model',
//                     style: pw.TextStyle(
//                       fontSize: 9,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Text(
//                     'CRIS/Vin Number',
//                     style: pw.TextStyle(
//                       fontSize: 9,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             pw.TableRow(
//               children: [
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Text(
//                     formData.customerName.isNotEmpty
//                         ? formData.customerName
//                         : 'Not provided',
//                     style: pw.TextStyle(fontSize: 9),
//                   ),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Text(
//                     formData.makeModel.isNotEmpty
//                         ? formData.makeModel
//                         : 'Not provided',
//                     style: pw.TextStyle(fontSize: 9),
//                   ),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Text(
//                     formData.crisVinNumber.isNotEmpty
//                         ? formData.crisVinNumber
//                         : 'Not provided',
//                     style: pw.TextStyle(fontSize: 9),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         pw.SizedBox(height: 10),
//         pw.Divider(thickness: 1),
//       ],
//     );
//   }

//   // Individual section builders for each category
//   static pw.Widget _buildPartsIncludedSection(EngineVehicleModel formData) {
//     return _buildSectionWithCheckboxes('Parts Included', [
//       'Engine Oil',
//       'Oil Filter',
//     ], formData.miniServiceData['Parts Included'] ?? {});
//   }

//   static pw.Widget _buildTopupsIncludedSection(EngineVehicleModel formData) {
//     return _buildSectionWithCheckboxes('Top-ups Included', [
//       'Windscreen Additive',
//       'Coolant',
//       'Brake Fluid',
//       'Power Steering Fluid',
//     ], formData.miniServiceData['Top-ups Included'] ?? {});
//   }

//   static pw.Widget _buildGeneralChecksSection(EngineVehicleModel formData) {
//     return _buildSectionWithCheckboxes('General Checks', [
//       'External Lights',
//       'Instrument warning',
//     ], formData.miniServiceData['General Checks'] ?? {});
//   }

//   static pw.Widget _buildInternalVisionSection(EngineVehicleModel formData) {
//     return _buildSectionWithCheckboxes('Internal/Vision', [
//       'Condition of Windscreen',
//       'Wiper and Washers',
//     ], formData.miniServiceData['Internal/Vision'] ?? {});
//   }

//   static pw.Widget _buildEngineSection(EngineVehicleModel formData) {
//     return _buildSectionWithCheckboxes('Engine', [
//       'General Oil Leaks',
//       'Antifreeze Strength',
//       'Timing Belt',
//     ], formData.miniServiceData['Engine'] ?? {});
//   }

//   static pw.Widget _buildBrakeSection(EngineVehicleModel formData) {
//     return _buildSectionWithCheckboxes('Brake', [
//       'Visual Check of brake pads',
//     ], formData.miniServiceData['Brake'] ?? {});
//   }

//   static pw.Widget _buildWheelsTyresSection(EngineVehicleModel formData) {
//     return _buildSectionWithCheckboxes('Wheels & Tyres', [
//       'Tyre Condition',
//       'Tyre Pressure',
//     ], formData.miniServiceData['Wheels & Tyres'] ?? {});
//   }

//   static pw.Widget _buildSteeringSuspensionSection(
//     EngineVehicleModel formData,
//   ) {
//     return _buildSectionWithCheckboxes(
//       'Steering & Suspension',
//       ['Steering Rack condition'],
//       formData.miniServiceData['Steering & Suspension'] ?? {},
//     );
//   }

//   static pw.Widget _buildExhaustSection(EngineVehicleModel formData) {
//     return _buildSectionWithCheckboxes('Exhaust', [
//       'Exhaust condition',
//     ], formData.miniServiceData['Exhaust'] ?? {});
//   }

//   static pw.Widget _buildDriveSystemSection(EngineVehicleModel formData) {
//     return _buildSectionWithCheckboxes('Drive System', [
//       'Clutch Fluid level',
//       'Transmission oil',
//     ], formData.miniServiceData['Drive System'] ?? {});
//   }

//   static pw.Widget _buildSectionWithCheckboxes(
//     String title,
//     List<String> items,
//     Map<String, String> formData,
//   ) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(
//           title,
//           style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
//         ),
//         pw.SizedBox(height: 6),
//         pw.Table(
//           border: pw.TableBorder.all(width: 0.5),
//           columnWidths: {
//             0: const pw.FlexColumnWidth(3),
//             1: const pw.FlexColumnWidth(0.5),
//             2: const pw.FlexColumnWidth(0.5),
//             3: const pw.FlexColumnWidth(0.5),
//             4: const pw.FlexColumnWidth(0.5),
//           },
//           children: [
//             // Header row
//             pw.TableRow(
//               decoration: pw.BoxDecoration(color: PdfColors.grey300),
//               children: [
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Text(
//                     '',
//                     style: pw.TextStyle(
//                       fontSize: 9,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Center(
//                     child: pw.Text(
//                       'P',
//                       style: pw.TextStyle(
//                         fontSize: 9,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Center(
//                     child: pw.Text(
//                       'F',
//                       style: pw.TextStyle(
//                         fontSize: 9,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Center(
//                     child: pw.Text(
//                       'N/A',
//                       style: pw.TextStyle(
//                         fontSize: 9,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4.0),
//                   child: pw.Center(
//                     child: pw.Text(
//                       'R',
//                       style: pw.TextStyle(
//                         fontSize: 9,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Item rows
//             for (var item in items)
//               pw.TableRow(
//                 children: [
//                   pw.Padding(
//                     padding: const pw.EdgeInsets.all(4.0),
//                     child: pw.Text(item, style: pw.TextStyle(fontSize: 9)),
//                   ),
//                   // Centered checkbox cells
//                   pw.Padding(
//                     padding: const pw.EdgeInsets.all(4.0),
//                     child: pw.Center(
//                       child: _buildCheckboxCell(formData[item] == 'P'),
//                     ),
//                   ),
//                   pw.Padding(
//                     padding: const pw.EdgeInsets.all(4.0),
//                     child: pw.Center(
//                       child: _buildCheckboxCell(formData[item] == 'F'),
//                     ),
//                   ),
//                   pw.Padding(
//                     padding: const pw.EdgeInsets.all(4.0),
//                     child: pw.Center(
//                       child: _buildCheckboxCell(formData[item] == 'N/A'),
//                     ),
//                   ),
//                   pw.Padding(
//                     padding: const pw.EdgeInsets.all(4.0),
//                     child: pw.Center(
//                       child: _buildCheckboxCell(formData[item] == 'R'),
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//         pw.SizedBox(height: 8),
//       ],
//     );
//   }

//   static pw.Widget _buildCheckboxCell(bool isChecked) {
//     return pw.Container(
//       width: 12,
//       height: 12,
//       alignment: pw.Alignment.center,
//       child: pw.Container(
//         width: 10,
//         height: 10,
//         decoration: pw.BoxDecoration(
//           border: pw.Border.all(color: PdfColors.black, width: 0.5),
//           color: isChecked ? PdfColors.black : PdfColors.white,
//         ),
//       ),
//     );
//   }

//   static pw.Widget _buildCommentsSection(EngineVehicleModel formData) {
//     if (formData.comments.isEmpty) return pw.Container();

//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text(
//           'ADDITIONAL COMMENTS',
//           style: pw.TextStyle(
//             fontSize: 12,
//             fontWeight: pw.FontWeight.bold,
//             color: PdfColors.blue800,
//           ),
//         ),
//         pw.SizedBox(height: 8),
//         pw.Container(
//           width: double.infinity,
//           padding: const pw.EdgeInsets.all(12.0),
//           decoration: pw.BoxDecoration(
//             border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
//             borderRadius: pw.BorderRadius.circular(4),
//           ),
//           child: pw.Text(formData.comments, style: pw.TextStyle(fontSize: 10)),
//         ),
//       ],
//     );
//   }

//   static pw.Widget _buildPageFooter(int pageNumber) {
//     return pw.Container(
//       width: double.infinity,
//       child: pw.Row(
//         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//         children: [
//           pw.Text('Part $pageNumber of 2', style: pw.TextStyle(fontSize: 9)),
//           pw.Text(
//             'Generated on: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
//             style: pw.TextStyle(fontSize: 9),
//           ),
//         ],
//       ),
//     );
//   }

//   static Future<pw.MemoryImage?> _loadDefaultLogoImage() async {
//     try {
//       final byteData = await rootBundle.load('assets/images/logo.png');
//       final Uint8List imageBytes = byteData.buffer.asUint8List();
//       return pw.MemoryImage(imageBytes);
//     } catch (e) {
//       print('Error loading default logo image: $e');
//       return null;
//     }
//   }
// }
// engine_vehicle_pdf.dart
import 'dart:typed_data';
import 'package:data/models/engine_vehicle_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class EngineVehiclePdfService {
  static Future<Uint8List> generatePdf(
    EngineVehicleModel formData, {
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

              // First Row: Parts Included and Top-ups Included
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildPartsIncludedSection(formData)),
                  pw.SizedBox(width: 10),
                  pw.Expanded(child: _buildTopupsIncludedSection(formData)),
                ],
              ),
              pw.SizedBox(height: 10),

              // Second Row: General Checks and Internal/Vision
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildGeneralChecksSection(formData)),
                  pw.SizedBox(width: 10),
                  pw.Expanded(child: _buildInternalVisionSection(formData)),
                ],
              ),
              pw.SizedBox(height: 10),

              // Third Row: Engine and Brake
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildEngineSection(formData)),
                  pw.SizedBox(width: 10),
                  pw.Expanded(child: _buildBrakeSection(formData)),
                ],
              ),
              pw.SizedBox(height: 10),
              _buildPageFooter(1),
            ],
          );
        },
      ),
    );

    // Add second page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(formData, logoImage),
              pw.SizedBox(height: 10),

              // First Row: Wheels & Tyres and Steering & Suspension
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildWheelsTyresSection(formData)),
                  pw.SizedBox(width: 10),
                  pw.Expanded(child: _buildSteeringSuspensionSection(formData)),
                ],
              ),
              pw.SizedBox(height: 10),

              // Second Row: Exhaust and Drive System
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildExhaustSection(formData)),
                  pw.SizedBox(width: 10),
                  pw.Expanded(child: _buildDriveSystemSection(formData)),
                ],
              ),
              pw.SizedBox(height: 10),
              _buildCommentsSection(formData),
              pw.SizedBox(height: 10),
              _buildPageFooter(2),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(
    EngineVehicleModel formData,
    pw.ImageProvider? logoImage,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Logo, Title, and Workshop Info Row
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Logo
            if (logoImage != null)
              pw.Container(width: 100, height: 50, child: pw.Image(logoImage))
            else
              pw.Container(
                width: 100,
                height: 50,
                child: pw.Text('LOGO', style: pw.TextStyle(fontSize: 9)),
              ),

            pw.SizedBox(width: 15),
            // Title
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Engine Vehicle Service Form',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.start,
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text(
                    'Professional Vehicle Maintenance Record',
                    style: pw.TextStyle(fontSize: 9),
                    textAlign: pw.TextAlign.start,
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Service Technician: Please ensure that every question is answered correctly using: P (pass), F (fail), N/A (not applicable) & R (rectified)',
                    style: pw.TextStyle(fontSize: 9),
                    textAlign: pw.TextAlign.start,
                  ),
                ],
              ),
            ),

            pw.SizedBox(width: 15),

            // Workshop Info - Right side
            pw.Container(
              width: 120,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Approved Workshop Name & Address',
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    formData.workshopName.isNotEmpty
                        ? formData.workshopName
                        : 'Not provided',
                    style: pw.TextStyle(fontSize: 7),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Job Reference/Date',
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    '${formData.jobReference.isNotEmpty ? formData.jobReference : 'Not provided'} / ${DateFormat('yyyy-MM-dd').format(formData.serviceDate ?? DateTime.now())}',
                    style: pw.TextStyle(fontSize: 7),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),

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

  // Individual section builders for each category
  static pw.Widget _buildPartsIncludedSection(EngineVehicleModel formData) {
    return _buildSectionWithCheckboxes('Parts Included', [
      'Engine Oil',
      'Oil Filter',
    ], formData.miniServiceData['Parts Included'] ?? {});
  }

  static pw.Widget _buildTopupsIncludedSection(EngineVehicleModel formData) {
    return _buildSectionWithCheckboxes('Top-ups Included', [
      'Windscreen Additive',
      'Coolant',
      'Brake Fluid',
      'Power Steering Fluid',
    ], formData.miniServiceData['Top-ups Included'] ?? {});
  }

  static pw.Widget _buildGeneralChecksSection(EngineVehicleModel formData) {
    return _buildSectionWithCheckboxes('General Checks', [
      'External Lights',
      'Instrument warning',
    ], formData.miniServiceData['General Checks'] ?? {});
  }

  static pw.Widget _buildInternalVisionSection(EngineVehicleModel formData) {
    return _buildSectionWithCheckboxes('Internal/Vision', [
      'Condition of Windscreen',
      'Wiper and Washers',
    ], formData.miniServiceData['Internal/Vision'] ?? {});
  }

  static pw.Widget _buildEngineSection(EngineVehicleModel formData) {
    return _buildSectionWithCheckboxes('Engine', [
      'General Oil Leaks',
      'Antifreeze Strength',
      'Timing Belt',
    ], formData.miniServiceData['Engine'] ?? {});
  }

  static pw.Widget _buildBrakeSection(EngineVehicleModel formData) {
    return _buildSectionWithCheckboxes('Brake', [
      'Visual Check of brake pads',
    ], formData.miniServiceData['Brake'] ?? {});
  }

  static pw.Widget _buildWheelsTyresSection(EngineVehicleModel formData) {
    return _buildSectionWithCheckboxes('Wheels & Tyres', [
      'Tyre Condition',
      'Tyre Pressure',
    ], formData.miniServiceData['Wheels & Tyres'] ?? {});
  }

  static pw.Widget _buildSteeringSuspensionSection(
    EngineVehicleModel formData,
  ) {
    return _buildSectionWithCheckboxes(
      'Steering & Suspension',
      ['Steering Rack condition'],
      formData.miniServiceData['Steering & Suspension'] ?? {},
    );
  }

  static pw.Widget _buildExhaustSection(EngineVehicleModel formData) {
    return _buildSectionWithCheckboxes('Exhaust', [
      'Exhaust condition',
    ], formData.miniServiceData['Exhaust'] ?? {});
  }

  static pw.Widget _buildDriveSystemSection(EngineVehicleModel formData) {
    return _buildSectionWithCheckboxes('Drive System', [
      'Clutch Fluid level',
      'Transmission oil',
    ], formData.miniServiceData['Drive System'] ?? {});
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
                  child: pw.Center(
                    child: pw.Text(
                      'P',
                      style: pw.TextStyle(
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Center(
                    child: pw.Text(
                      'F',
                      style: pw.TextStyle(
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Center(
                    child: pw.Text(
                      'N/A',
                      style: pw.TextStyle(
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Center(
                    child: pw.Text(
                      'R',
                      style: pw.TextStyle(
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                      ),
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
                  // Centered checkbox cells
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Center(
                      child: _buildCheckboxCell(formData[item] == 'P'),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Center(
                      child: _buildCheckboxCell(formData[item] == 'F'),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Center(
                      child: _buildCheckboxCell(formData[item] == 'N/A'),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Center(
                      child: _buildCheckboxCell(formData[item] == 'R'),
                    ),
                  ),
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
      width: 12,
      height: 12,
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

  static pw.Widget _buildCommentsSection(EngineVehicleModel formData) {
    if (formData.comments.isEmpty) return pw.Container();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Text(
        //   'ADDITIONAL COMMENTS',
        //   style: pw.TextStyle(
        //     fontSize: 12,
        //     fontWeight: pw.FontWeight.bold,
        //     color: PdfColors.blue800,
        //   ),
        // ),
        // pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          columnWidths: {0: const pw.FlexColumnWidth(1)},
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Comments',
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
                    formData.comments,
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

  static pw.Widget _buildPageFooter(int pageNumber) {
    return pw.Container(
      width: double.infinity,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Part $pageNumber of 2', style: pw.TextStyle(fontSize: 9)),
          pw.Text(
            'Generated on: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
            style: pw.TextStyle(fontSize: 9),
          ),
        ],
      ),
    );
  }

  static Future<pw.MemoryImage?> _loadDefaultLogoImage() async {
    try {
      final byteData = await rootBundle.load('assets/images/logo.png');
      final Uint8List imageBytes = byteData.buffer.asUint8List();
      return pw.MemoryImage(imageBytes);
    } catch (e) {
      print('Error loading default logo image: $e');
      return null;
    }
  }
}
