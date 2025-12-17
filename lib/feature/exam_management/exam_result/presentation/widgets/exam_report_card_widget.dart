// Flutter Report Card Sample with PDF generation
// Requires: add `pdf` and `printing` packages in pubspec.yaml
//   dependencies:
//     pdf: ^3.10.7
//     printing: ^5.12.0
// This example shows both an on-screen card and a button to export as PDF.

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportCardSample extends StatelessWidget {
  const ReportCardSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Report Card Preview'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final pdf = await _generatePdf();
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async => pdf.save(),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text("Report card preview here (see UI implementation above)"),
      ),
    );
  }

  Future<pw.Document> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // Header
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 60,
                      height: 60,
                      color: PdfColors.grey300,
                      child: pw.Center(child: pw.Text("Logo")),
                    ),
                    pw.SizedBox(width: 12),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("SILVER SPRING ACADEMY",
                              style: pw.TextStyle(
                                  fontSize: 20, fontWeight: pw.FontWeight.bold)),
                          pw.Text("15 Palm Avenue, Victoria Island, Lagos"),
                          pw.SizedBox(height: 4),
                          pw.Divider(),
                          pw.Text("TERMLY EXAMS RESULT CARD",
                              style: pw.TextStyle(
                                  fontSize: 14, fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                    ),
                    pw.Container(
                      width: 80,
                      height: 100,
                      color: PdfColors.grey300,
                      child: pw.Center(child: pw.Text("Photo")),
                    ),
                  ],
                ),

                pw.SizedBox(height: 16),

                // Student Info
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  children: [
                    _infoRow("Name", "Adeola Johnson"),
                    _infoRow("Admission No.", "SSA/2023/045"),
                    _infoRow("Class", "JSS 2B"),
                    _infoRow("Session", "2024/2025"),
                    _infoRow("Term", "Second Term"),
                  ],
                ),

                pw.SizedBox(height: 16),

                // Subjects
                pw.Text("Subject Performance",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3),
                    1: const pw.FlexColumnWidth(1),
                    2: const pw.FlexColumnWidth(1),
                    3: const pw.FlexColumnWidth(1),
                    4: const pw.FlexColumnWidth(3),
                  },
                  children: [
                    _subjectHeader(),
                    _subjectRow("Mathematics", "85", "A", "2nd", "Excellent"),
                    _subjectRow("English", "70", "A", "5th", "Good effort"),
                    _subjectRow("Basic Science", "65", "B", "6th", "Improving"),
                    _subjectRow("Social Studies", "60", "B", "7th", "Keep it up"),
                    _subjectRow("Agric Science", "55", "C", "12th", "Needs focus"),
                  ],
                ),

                pw.SizedBox(height: 16),

                // Psychomotor
                pw.Text("Psychomotor Domain",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  children: [
                    _infoRow("Punctuality", "A"),
                    _infoRow("Neatness", "A"),
                    _infoRow("Honesty", "B"),
                    _infoRow("Leadership", "A"),
                    _infoRow("Teamwork", "A"),
                    _infoRow("Creativity", "B"),
                    _infoRow("Sportsmanship", "B"),
                  ],
                ),

                pw.SizedBox(height: 16),

                // Remarks
                pw.Text("Class Teacher's Remark: Adeola has shown great improvement this term."),
                pw.SizedBox(height: 6),
                pw.Text("Principal's Remark: Excellent performance overall. Continue to aim higher."),

                pw.SizedBox(height: 20),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(children: [
                      pw.Text("Examiner's Signature"),
                      pw.SizedBox(height: 40),
                      pw.Container(width: 100, height: 30, color: PdfColors.grey300),
                    ]),
                    pw.Column(children: [
                      pw.Text("School Stamp"),
                      pw.SizedBox(height: 10),
                      pw.Container(width: 60, height: 60, color: PdfColors.grey300),
                    ]),
                  ],
                ),

                pw.SizedBox(height: 20),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                      "Date of Issue: ${DateTime.now().toLocal().toString().split(" ")[0]}",
                      style: const pw.TextStyle(fontSize: 10)),
                )
              ],
            )
          ];
        },
      ),
    );

    return pdf;
  }

  pw.TableRow _infoRow(String label, String value) {
    return pw.TableRow(children: [
      pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
      pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(value)),
    ]);
  }

  pw.TableRow _subjectHeader() {
    return pw.TableRow(children: [
      _headerCell("Subject"),
      _headerCell("Score"),
      _headerCell("Grade"),
      _headerCell("Pos."),
      _headerCell("Remark"),
    ]);
  }

  pw.TableRow _subjectRow(
      String subject, String score, String grade, String pos, String remark) {
    return pw.TableRow(children: [
      _cell(subject),
      _cell(score),
      _cell(grade),
      _cell(pos),
      _cell(remark),
    ]);
  }

  pw.Widget _headerCell(String text) {
    return pw.Padding(
        padding: const pw.EdgeInsets.all(6),
        child: pw.Text(text, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)));
  }

  pw.Widget _cell(String text) {
    return pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(text));
  }
}
