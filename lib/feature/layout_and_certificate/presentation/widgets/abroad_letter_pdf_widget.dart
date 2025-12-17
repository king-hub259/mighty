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

class AbroadLetterPdfPreviewPage extends StatelessWidget {
  const AbroadLetterPdfPreviewPage({super.key});

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    var institute = systemController.generalSettingModel?.data;

    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(pw.Page(pageFormat: format,
      margin: const pw.EdgeInsets.all(32), build: (pw.Context context) {
          return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: [
              // Header: 3 columns
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                  pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                      pw.Text(
                        institute?.schoolName ?? 'Demo Collage 11',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? 'Asia, Dhaka'),
                      pw.Text('Tel:${institute?.phone ??''}+88-123456789'),
                      pw.Text('${institute?.eiinCode ??''}1300'),
                    ]),

                  pw.Image(logoImage, width: 80, height: 60),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                      pw.Text(institute?.schoolName ?? 'Demo Collage 11',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(institute?.address ?? 'Asia, Dhaka'),
                      pw.Text('Tel:${institute?.phone ??''}+88-123456789'),
                      pw.Text('${institute?.eiinCode ??''}1300'),
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 16),

              // Date
              pw.Align(alignment: pw.Alignment.centerRight,
                child: pw.Text('Date: ${AppConstants.currentDate}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              pw.SizedBox(height: 32),

              // Title
              pw.Center(child: pw.Text('TO WHOM IT MAY CONCERN',
                  style: pw.TextStyle(fontSize: 16,
                    fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline),
                ),
              ),
              pw.SizedBox(height: 32),

              // Body
              pw.RichText(
                text: pw.TextSpan(children: [
                  const pw.TextSpan(text: 'This is to certify that '),
                  pw.TextSpan(text: '${data?.studentSession?.student?.firstName ?? 'Darrion'} ${data?.studentSession?.student?.lastName ?? 'Kassulke'} (Roll # ${data?.studentSession?.roll ?? '--'})',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  const pw.TextSpan(text: ' , son of '),
                  pw.TextSpan(text: data?.studentSession?.student?.fatherName ?? 'Brandt Adams',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: ' and '),

                    pw.TextSpan(text: data?.studentSession?.student?.motherName ?? 'Estrella Hills',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: ' was a student of '),
                    pw.TextSpan(text: institute?.schoolName ?? 'Demo Collage 11',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: ' in '),
                    pw.TextSpan(text: data?.studentSession?.student?.studentGroup?.groupName ?? 'Food Processing',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic)),
                    const pw.TextSpan(text: ' group in the session of '),

                    pw.TextSpan(text: data?.studentSession?.session?.year ?? '2024-2025',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: '. He appeared in the HSC Exam- under Board of Intermediate and Secondary Education, Asia, Dhaka bearing '),

                    pw.TextSpan(text: 'Roll: ${data?.studentSession?.roll ?? '--'}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    const pw.TextSpan(text: ' . He passed and obtained on a scale of 5.00.'),
                  ],

                  style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
                ),
              ),

              pw.SizedBox(height: 24),

              pw.Text('To the best of my knowledge he did not participate in any anti-state activity and/or anti-discipline of the College. He bears a good moral character.',
                style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic)),

              pw.SizedBox(height: 24),

              pw.Text(
                'Any assistance given to him will be highly appreciated.',
                style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
              ),

              pw.Spacer(),

              // Signature Section
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Sincerely', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 40),
                    pw.Container(
                      width: 120,
                      height: 60,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey),
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text('------------------------------', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Principal'),
                    pw.Text(institute?.schoolName ?? 'Demo Collage 11'),
                  ],
                ),
              )
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
      appBar: AppBar(title: const Text("Preview Abroad Letter PDF")),
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
