import 'dart:typed_data';
import 'package:data/models/safety_inspection_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class SafetyInspectionPdfService {
  static Future<Uint8List> generatePdf(
    SafetyInspectionModel formData, {
    Uint8List? logoImageBytes,
  }) async {
    final pdf = pw.Document();

    // Load logo image
    final logoImage =
        logoImageBytes != null
            ? pw.MemoryImage(logoImageBytes)
            : await _loadDefaultLogoImage();

    // Add first page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(formData, logoImage),
              pw.SizedBox(height: 10),

              // First Row: Insider Cab and Vehicle Ground Level
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: _buildInspectionSection(
                      'Insider Cab',
                      [
                        'Drivers seat*',
                        'Seat belts*',
                        'Mirrors*',
                        'Glass & Road View*',
                        'Accessibility Features*',
                        'Horn*',
                      ],
                      formData,
                      comments: formData.insiderCabComments,
                    ),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                    child: _buildInspectionSection(
                      'Vehicle Ground Level',
                      [
                        'Security of body*',
                        'Exhaust emission*',
                        'Road wheels & hubs*',
                        'Size & types of tyres*',
                        'Condition of tyres*',
                        'Bumper bars*',
                      ],
                      formData,
                      comments: formData.vehicleGroundLevelComments,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),

              // Second Row: Brake Performance and General Servicing
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: _buildTextBasedSection('Brake Performance', [
                      'Service Brake Performance*',
                      'Brake Performance*',
                      'Parking Brake Performance*',
                    ], formData),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                    child: _buildTextBasedSection('General Servicing', [
                      'Vehicle excise duty*',
                      'PSV*',
                      'Technograph calibration*',
                    ], formData),
                  ),
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

              // First Row: Inspection Report and Comments on faults found
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildInspectionReportSection(formData)),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                    child: _buildCommentsOnFaultsFoundSection(formData),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),

              // Second Row: Action taken and Consider defects
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(child: _buildActionTakenSection(formData)),
                  pw.SizedBox(width: 10),
                  pw.Expanded(child: _buildConsiderDefectsSection(formData)),
                ],
              ),

              // Final Comments section if exists
              if (formData.comments.isNotEmpty)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 10),
                    _buildCommentsSection('Final Comments', formData.comments),
                  ],
                ),

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
    SafetyInspectionModel formData,
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
                    'Safety Inspection Form',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.start,
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text(
                    'Professional Vehicle Safety Inspection Record',
                    style: pw.TextStyle(fontSize: 9),
                    textAlign: pw.TextAlign.start,
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Safety Inspector: Please ensure that every item is checked using: V (Verified), R (Rectified), X (Failed), N/A (Not Applicable)',
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
                    '${formData.jobReference.isNotEmpty ? formData.jobReference : 'Not provided'} / ${DateFormat('yyyy-MM-dd').format(formData.inspectionDate ?? DateTime.now())}',
                    style: pw.TextStyle(fontSize: 7),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),

        // Vehicle info table
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
                    'Vehicle Registration',
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
                    'Operator',
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
                    formData.vehicleRegistration.isNotEmpty
                        ? formData.vehicleRegistration
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
                    formData.operator.isNotEmpty
                        ? formData.operator
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

  static pw.Widget _buildInspectionSection(
    String title,
    List<String> items,
    SafetyInspectionModel formData, {
    String comments = '',
  }) {
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
                      'V',
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
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Center(
                    child: pw.Text(
                      'X',
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
              ],
            ),
            // Item rows
            for (var item in items)
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Text(
                      item.replaceAll('*', ''),
                      style: pw.TextStyle(fontSize: 9),
                    ),
                  ),
                  // Centered checkbox cells
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Center(
                      child: _buildCheckboxCell(
                        formData.selectedValues[item] == 'V',
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Center(
                      child: _buildCheckboxCell(
                        formData.selectedValues[item] == 'R',
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Center(
                      child: _buildCheckboxCell(
                        formData.selectedValues[item] == 'X',
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Center(
                      child: _buildCheckboxCell(
                        formData.selectedValues[item] == 'N/A',
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),

        // Comments section below the table - only if comments exist
        if (comments.isNotEmpty) ...[
          pw.SizedBox(height: 4),
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
                    child: pw.Text(comments, style: pw.TextStyle(fontSize: 8)),
                  ),
                ],
              ),
            ],
          ),
        ],

        pw.SizedBox(height: 8),
      ],
    );
  }

  static pw.Widget _buildTextBasedSection(
    String title,
    List<String> items,
    SafetyInspectionModel formData,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 6),
        // Create a table for text-based sections with borders
        pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          columnWidths: {
            0: const pw.FlexColumnWidth(2),
            1: const pw.FlexColumnWidth(3),
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Item',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Details',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Item rows with bordered text fields
            for (var item in items)
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Text(
                      item.replaceAll('*', ''),
                      style: pw.TextStyle(fontSize: 9),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        for (var field
                            in formData.inspectionData[item]?.keys ?? [])
                          pw.Container(
                            width: double.infinity,
                            padding: const pw.EdgeInsets.all(2.0),
                            child: pw.Text(
                              formData.inspectionData[item]?[field] ??
                                  'Not provided',
                              style: pw.TextStyle(fontSize: 8),
                            ),
                          ),
                        if ((formData.inspectionData[item]?.keys ?? []).isEmpty)
                          pw.Container(
                            width: double.infinity,
                            padding: const pw.EdgeInsets.all(2.0),
                            child: pw.Text(
                              'Not provided',
                              style: pw.TextStyle(fontSize: 8),
                            ),
                          ),
                      ],
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

  static pw.Widget _buildInspectionReportSection(
    SafetyInspectionModel formData,
  ) {
    return _buildSimpleSectionWithBorders('Inspection Report', {
      'Seen on': formData.seenOn.isNotEmpty ? formData.seenOn : 'Not provided',
      'Signed by':
          formData.signedBy.isNotEmpty ? formData.signedBy : 'Not provided',
      'TM Operator':
          formData.tmOperator.isNotEmpty ? formData.tmOperator : 'Not provided',
    });
  }

  static pw.Widget _buildCommentsOnFaultsFoundSection(
    SafetyInspectionModel formData,
  ) {
    return _buildSimpleSectionWithBorders('Comments on faults found', {
      'Check Number':
          formData.checkNumber.isNotEmpty
              ? formData.checkNumber
              : 'Not provided',
      'Fault Details':
          formData.faultDetails.isNotEmpty
              ? formData.faultDetails
              : 'Not provided',
      'Signature Of Inspector':
          formData.signatureOfInspector.isNotEmpty
              ? formData.signatureOfInspector
              : 'Not provided',
      'Name Of Inspector':
          formData.nameOfInspector.isNotEmpty
              ? formData.nameOfInspector
              : 'Not provided',
    });
  }

  static pw.Widget _buildActionTakenSection(SafetyInspectionModel formData) {
    return _buildSimpleSectionWithBorders('Action taken on faults found', {
      'Action taken on fault':
          formData.actionTakenOnFault.isNotEmpty
              ? formData.actionTakenOnFault
              : 'Not provided',
      'Rectified by':
          formData.rectifiedBy.isNotEmpty
              ? formData.rectifiedBy
              : 'Not provided',
    });
  }

  static pw.Widget _buildConsiderDefectsSection(
    SafetyInspectionModel formData,
  ) {
    return _buildSimpleSectionWithBorders('Consider defects have', {
      'Rectified satisfactorily':
          formData.rectifiedSatisfactorily.isNotEmpty
              ? formData.rectifiedSatisfactorily
              : 'Not provided',
      'Needs more work done':
          formData.needsMoreWorkDone.isNotEmpty
              ? formData.needsMoreWorkDone
              : 'Not provided',
      'Signature Of Mechanic':
          formData.signatureOfMechanic.isNotEmpty
              ? formData.signatureOfMechanic
              : 'Not provided',
      'Date': formData.date.isNotEmpty ? formData.date : 'Not provided',
    });
  }

  static pw.Widget _buildSimpleSectionWithBorders(
    String title,
    Map<String, String> data,
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
            0: const pw.FlexColumnWidth(2),
            1: const pw.FlexColumnWidth(3),
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Field',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4.0),
                  child: pw.Text(
                    'Value',
                    style: pw.TextStyle(
                      fontSize: 9,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Data rows
            for (var entry in data.entries)
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Text(
                      entry.key,
                      style: pw.TextStyle(
                        fontSize: 9,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4.0),
                    child: pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.all(2.0),
                      child: pw.Text(
                        entry.value,
                        style: pw.TextStyle(fontSize: 8),
                      ),
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

  static pw.Widget _buildCommentsSection(String title, String comments) {
    if (comments.isEmpty) return pw.Container();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue800,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(12.0),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Text(comments, style: pw.TextStyle(fontSize: 10)),
        ),
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
