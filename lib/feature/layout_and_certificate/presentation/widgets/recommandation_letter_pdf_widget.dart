import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/images.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
import 'package:printing/printing.dart';

class RecommendationLetterPdfPreviewPage extends StatelessWidget {
  const RecommendationLetterPdfPreviewPage({super.key});

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    var institute = systemController.generalSettingModel?.data;
    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(pw.Page(pageFormat: format,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: [

            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text(institute?.schoolName ?? 'N/A', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(institute?.address ?? 'Asia, Dhaka'),
                pw.Text('Tel:${institute?.phone ??'N/A'}'),
                pw.Text(institute?.eiinCode ??'N/A'),
              ]),
              pw.Image(logoImage, width: 80, height: 60),
              pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text(institute?.schoolName ?? 'N/A', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(institute?.address ?? 'Asia, Dhaka'),
                pw.Text('Tel:${institute?.phone ??'N/A'}'),
                pw.Text(institute?.eiinCode ??'N/A'),
              ]),
            ]),
            pw.SizedBox(height: 8),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 16),




          pw.Align(alignment: pw.Alignment.centerRight, child: pw.Text('Date: ${AppConstants.currentDate}',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              pw.SizedBox(height: 16),

              // Title
            pw.Center(child: pw.Text('TO WHOM IT MAY CONCERN', style: pw.TextStyle(fontSize: 16,
                fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline))),
            pw.SizedBox(height: 24),

              // Body
            pw.RichText(text: pw.TextSpan(
              children: [
                const pw.TextSpan(text: 'This is to certify that '),
                pw.TextSpan(text: '${data?.studentSession?.student?.firstName ?? 'Darrion'} ${data?.studentSession?.student?.lastName ?? 'Kassulke'} (Roll # ${data?.studentSession?.roll ?? '--'})',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                const pw.TextSpan(text: ' , son of '),
                pw.TextSpan(text: data?.studentSession?.student?.fatherName ?? 'Brandt Adams',
                  style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
                const pw.TextSpan(text: ' and '),

                pw.TextSpan(text: data?.studentSession?.student?.motherName ?? 'Estrella Hills', style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
                pw.TextSpan(text: ' is a student of ${data?.studentSession?.classItem?.className} in '),
                pw.TextSpan(text: institute?.schoolName ?? ' N/A', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic)),
                pw.TextSpan(text: data?.studentSession?.student?.studentGroup?.groupName ?? 'Food Processing',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic)),
                  ],
                  style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic))),

              pw.SizedBox(height: 24),
              pw.Text('Any assistance given to him will be highly appreciated.',
                style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic)),
              pw.Spacer(),


              pw.Align(alignment: pw.Alignment.centerRight,
                child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Sincerely'),
                    pw.SizedBox(height: 32),
                    pw.Text('-----------------------------------------', ),
                    pw.Text('Principal'),
                    pw.Text(institute?.schoolName ?? 'N/A'),
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
      appBar: AppBar(title: const Text("Preview PDF")),
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
