import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/images.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TransferCertificatePdfPreviewPage extends StatelessWidget {
  const TransferCertificatePdfPreviewPage({super.key});

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final controller = Get.find<LayoutAndCertificateController>();
    final data = controller.layoutAndCertificateModel?.data;
    final systemController = Get.find<SystemSettingsController>();
    var institute = systemController.generalSettingModel?.data;

    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // Header: 3 columns
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        institute?.schoolName ?? 'Demo Collage 11',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(institute?.address ?? 'Asia, Dhaka'),
                      pw.Text('Tel:${institute?.phone ?? '+88-123456789'}'),
                      pw.Text(institute?.eiinCode ?? '1300'),
                    ],
                  ),
                  pw.Image(logoImage, width: 80, height: 40),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        institute?.schoolName ?? 'Demo Collage 11',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(institute?.address ?? 'Asia, Dhaka'),
                      pw.Text('Tel:${institute?.phone ?? '+88-123456789'}'),
                      pw.Text(institute?.eiinCode ?? '1300'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 5),

              // Date
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Date: ${AppConstants.currentDate}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(height: 10),

              // Title
              pw.Center(child: pw.Text('TRANSFER CERTIFICATE', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline))),

              pw.SizedBox(height: 10),

              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                children: [
                  _buildTableRow('1. Name of Student:', '${data?.studentSession?.student?.firstName ?? 'Darrion'} ${data?.studentSession?.student?.lastName ?? 'Kassulke'}'),
                  _buildTableRow('2. Father\'s Name:', data?.studentSession?.student?.fatherName ?? 'Brandt Adams'),
                  _buildTableRow('3. Mother\'s Name:', data?.studentSession?.student?.motherName ?? 'Estrella Hills'),
                  _buildTableRow('4. Date of Birth:', data?.studentSession?.student?.birthday ?? '01/01/2000'),
                  _buildTableRow('5. Class in which studying:', data?.studentSession?.classItem?.className ?? 'Class 12'),
                  _buildTableRow('6. Roll Number:', data?.studentSession?.roll ?? '123'),
                  _buildTableRow('7. Registration Number:', (data?.studentSession?.student?.registerNo?.toString()) ?? '123456'),
                  _buildTableRow('8. Session:', data?.studentSession?.session?.year ?? '2024-2025'),
                  _buildTableRow('9. Group/Subject:', data?.studentSession?.student?.studentGroup?.groupName ?? 'Science'),
                  _buildTableRow('10. Date of Admission:', data?.studentSession?.session?.year ?? '01/07/2023'),
                  _buildTableRow('11. Date of Leaving:', ''),
                  _buildTableRow('12. Reason for Leaving:', 'Completion of Course'),
                  _buildTableRow('13. Character:', 'Good'),
                  _buildTableRow('14. Conduct:', 'Satisfactory'),
                  _buildTableRow('15. Last Exam Passed:', ''),
                  _buildTableRow('16. Result:', 'Passed'),
                ],
              ),

              pw.SizedBox(height: 10),

              // Date and signature
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Date: ${AppConstants.currentDate}}'),
                      pw.SizedBox(height: 8),
                      pw.Text('Place: ${institute?.address ?? 'Dhaka'}'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Container(
                        width: 120,
                        height: 40,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.grey),
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text('-----------------------------', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Principal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.schoolName ?? 'Demo Collage 11'),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return Uint8List.fromList(await pdf.save());
  }

  pw.TableRow _buildTableRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            label,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(value),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Transfer Certificate PDF")),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
        allowPrinting: true,
        allowSharing: true,
        useActions: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
      ),
    );
  }
}
