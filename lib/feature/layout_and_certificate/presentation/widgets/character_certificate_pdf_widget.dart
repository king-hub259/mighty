import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/images.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CharacterCertificatePdfPreviewPage extends StatelessWidget {
  const CharacterCertificatePdfPreviewPage({super.key});

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    var institute = systemController.generalSettingModel?.data;

    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        institute?.schoolName ?? 'Demo Collage 11',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(institute?.address ?? 'Asia, Dhaka'),
                      pw.Text('Tel:${institute?.phone ?? ''}'),
                      pw.Text(institute?.eiinCode ?? ''),
                    ],
                  ),
                  pw.Image(logoImage, width: 80, height: 60),
                ],
              ),

              pw.SizedBox(height: 24),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 24),

              // Date (Top right corner)
              pw.Align(alignment: pw.Alignment.centerRight, child: pw.Text('Date: ${AppConstants.currentDate}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),

              pw.SizedBox(height: 32),

              // Title
              pw.Center(child: pw.Text('CHARACTER CERTIFICATE', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline))),

              pw.SizedBox(height: 32),

              // Body
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    const pw.TextSpan(text: 'This is to certify that '),
                    pw.TextSpan(
                      text:
                      '${data?.studentSession?.student?.firstName ?? 'Darrion'} ${data?.studentSession?.student?.lastName ?? 'Kassulke'}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ', son of '),
                    pw.TextSpan(text: data?.studentSession?.student?.fatherName ?? 'Brandt Adams',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' and '),
                    pw.TextSpan(text: data?.studentSession?.student?.motherName ?? 'Estrella Hills', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: ' was a student of this institution from '),
                    pw.TextSpan(text: data?.studentSession?.session?.year ?? '01/07/2023', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: ' to '),

                    pw.TextSpan(text: '30/06/2025',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    const pw.TextSpan(text: ' in '),
                    pw.TextSpan(text: '${data?.studentSession?.student?.studentGroup?.groupName ?? 'Science'} Group', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: ' with Roll Number '),
                    pw.TextSpan(text: data?.studentSession?.roll ?? '123', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: '.'),
                  ],
                  style: const pw.TextStyle(fontSize: 14, height: 1.5),
                ),
              ),

              pw.SizedBox(height: 24),

              pw.Text('During his stay in this institution, his character and conduct were found to be good and satisfactory. He was regular in attendance and showed keen interest in his studies.',
                style: const pw.TextStyle(fontSize: 14, height: 1.5)),

              pw.SizedBox(height: 24),

              pw.Text('I wish him all success in his future endeavors.', style: const pw.TextStyle(fontSize: 14, height: 1.5)),

              pw.Spacer(),

              // Signature Section
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                  pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                      pw.Text('Date: ${AppConstants.currentDate}'),
                      pw.Text('Place: ${institute?.address ?? 'Dhaka'}'),
                    ],
                  ),
                  pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
                      pw.Container(width: 120, height: 60, decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey))),
                      pw.SizedBox(height: 8),
                      pw.Text('------------------------------', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
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
      appBar: AppBar(title: const Text("Preview Character Certificate PDF")),
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
