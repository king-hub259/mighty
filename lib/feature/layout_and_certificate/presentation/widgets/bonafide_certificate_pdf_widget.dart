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

class BonafideCertificatePdfPreviewPage extends StatelessWidget {
  const BonafideCertificatePdfPreviewPage({super.key});

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    var institute = systemController.generalSettingModel?.data;

    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(
      pw.Page(pageFormat: format, margin: pw.EdgeInsets.zero, build: (pw.Context context) {
          return pw.Container(decoration: pw.BoxDecoration(border: pw.Border.all(color: const PdfColor.fromInt(0xFF2E3192), width: 3)),
            child: pw.Container(
              margin: const pw.EdgeInsets.all(8), decoration: pw.BoxDecoration(
                border: pw.Border.all(color: const PdfColor.fromInt(0xFF2E3192), width: 1)),
              padding: const pw.EdgeInsets.all(24),
              child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: [
                  // Header
                  pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
                      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                          pw.Text(institute?.schoolName ?? 'Demo Collage 11',
                            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xFF2E3192))),
                          pw.Text(institute?.address ?? 'Asia, Dhaka'),
                          pw.Text(institute?.eiinCode ??''),
                        ],
                      ),
                      pw.Image(logoImage, width: 80, height: 60),
                    ],
                  ),

                  pw.SizedBox(height: 24),

                  // Date
                  pw.Align(alignment: pw.Alignment.centerRight, child: pw.Text('Date: ${AppConstants.currentDate}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),

                  pw.SizedBox(height: 24),

                  // Title
                  pw.Center(child: pw.Text('BONAFIDE CERTIFICATE',
                      style: pw.TextStyle(fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline, color: const PdfColor.fromInt(0xFF2E3192),),
                    ),
                  ),

                  pw.SizedBox(height: 32),

                  // Body
                  pw.RichText(
                    text: pw.TextSpan(children: [
                        const pw.TextSpan(text: 'This is to certify that '),
                        pw.TextSpan(text: '${data?.studentSession?.student?.firstName ?? 'Darrion'} ${data?.studentSession?.student?.lastName ?? 'Kassulke'}',
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
                        const pw.TextSpan(text: ' is a bonafide student of this institution. He is currently studying in '),
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
                        pw.TextSpan(text: data?.studentSession?.roll ?? '123',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        const pw.TextSpan(text: ' for the academic session '),
                        pw.TextSpan(
                          text: data?.studentSession?.session?.year ?? '2024-2025',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        const pw.TextSpan(text: '.'),
                      ],
                      style: const pw.TextStyle(fontSize: 13, height: 1.5),
                    ),
                  ),

                  pw.SizedBox(height: 24),

                  pw.Text(
                    'He is a regular and disciplined student of this institution.',
                    style: const pw.TextStyle(fontSize: 13, height: 1.5),
                  ),

                  pw.SizedBox(height: 24),

                  pw.Text(
                    'This certificate is issued on his request for official purposes.',
                    style: const pw.TextStyle(fontSize: 13, height: 1.5),
                  ),

                  pw.Spacer(),

                  // Signature Section
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Column(
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
                        pw.Text('------------------------------', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('Principal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(institute?.schoolName ?? 'Demo Collage 11'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return Uint8List.fromList(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Bonafide Certificate PDF")),
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
