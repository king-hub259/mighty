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

class StudyCertificatePdfPreviewPage extends StatelessWidget {
  const StudyCertificatePdfPreviewPage({super.key});

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    var institute = systemController.generalSettingModel?.data;

    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(
      pw.Page(pageFormat: format,
        margin: const pw.EdgeInsets.all(32), build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: [

              pw.Center(
                child: pw.Column(children: [
                    pw.Image(logoImage, width: 100, height: 75),
                    pw.SizedBox(height: 16),
                    pw.Text(institute?.schoolName ?? 'Demo Collage 11',
                      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      institute?.address ?? 'Asia, Dhaka',
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      'Tel: ${institute?.phone ?? ''} | EIIN: ${institute?.eiinCode ?? '123456'}',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 32),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 24),

              // Date
              pw.Align(alignment: pw.Alignment.centerRight,
                child: pw.Text('Date: ${AppConstants.currentDate}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),

              pw.SizedBox(height: 24),

              // Title
              pw.Center(child: pw.Text('STUDY CERTIFICATE',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline),
                ),
              ),

              pw.SizedBox(height: 32),

              // Body
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    const pw.TextSpan(text: 'This is to certify that '),
                    pw.TextSpan(
                      text: '${data?.studentSession?.student?.firstName ?? 'Darrion'} ${data?.studentSession?.student?.lastName ?? 'Kassulke'}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ', son of '),
                    pw.TextSpan(
                      text: data?.studentSession?.student?.fatherName ?? 'Brandt Adams',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' and '),
                    pw.TextSpan(
                      text: data?.studentSession?.student?.motherName ?? 'Estrella Hills',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' is a bonafide student of this institution studying in '),
                    pw.TextSpan(
                      text: data?.studentSession?.classItem?.className ?? 'Class 12',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ', '),
                    pw.TextSpan(
                      text: '${data?.studentSession?.student?.studentGroup?.groupName ?? 'Science'} Group',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' with Roll Number '),
                    pw.TextSpan(
                      text: data?.studentSession?.roll ?? '123',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' for the academic session '),
                    pw.TextSpan(
                      text: data?.studentSession?.session?.year ?? '2024-2025',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: '.'),
                  ],
                  style: const pw.TextStyle(fontSize: 14, height: 1.5),
                ),
              ),

              pw.SizedBox(height: 24),

              pw.Text(
                'He is a regular student and his conduct and character are satisfactory.',
                style: const pw.TextStyle(fontSize: 14, height: 1.5),
              ),

              pw.SizedBox(height: 24),

              pw.Text(
                'This certificate is issued for official purposes on his request.',
                style: const pw.TextStyle(fontSize: 14, height: 1.5),
              ),

              pw.Spacer(),

              // Signature Section
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Date: ${AppConstants.currentDate}'),
                      pw.Text('Place: ${institute?.address ?? 'Dhaka'}'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Container(
                        width: 120,
                        height: 60,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.grey),
                        ),
                      ),
                      pw.SizedBox(height: 8),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Study Certificate PDF")),
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
