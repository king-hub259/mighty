import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:mighty_school/util/images.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AttendanceCertificatePdfPreviewPage extends StatelessWidget {
  const AttendanceCertificatePdfPreviewPage({super.key});

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    var institute = systemController.generalSettingModel?.data;

    final logoImage = await loadNetworkImage(systemController.logoUrl);
    pdf.addPage(pw.Page(pageFormat: format, margin: pw.EdgeInsets.zero, build: (pw.Context context) {
      return pw.Container(decoration: pw.BoxDecoration(
        border: pw.Border.all(color: const PdfColor.fromInt(0xFF2E3192), width: 4),),
        child: pw.Container(margin: const pw.EdgeInsets.all(8), decoration: pw.BoxDecoration(
          border: pw.Border.all(color: const PdfColor.fromInt(0xFF2E3192), width: 2),),
          padding: const pw.EdgeInsets.all(32),
          child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: [

            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
              pw.Image(logoImage, width: 120, height: 90),

              pw.Expanded(child: pw.Column(children: [
                pw.Text(institute?.schoolName ?? 'DEMO COLLAGE 11',
                  style: pw.TextStyle(fontSize: 24,
                    fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF2E3192),),
                    textAlign: pw.TextAlign.center),
                pw.SizedBox(height: 8),

                pw.Text('Perfect Attendance', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF1B5E20)), textAlign: pw.TextAlign.center),
              ])),
              pw.SizedBox(width: 120), // Balance the layout
            ]),

            pw.SizedBox(height: 40),


            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Row(children: [
                pw.Text('Name: ', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic)),
                pw.Container(width: 200,
                  decoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black, style: pw.BorderStyle.dotted))),

                  child: pw.Text('${data?.studentSession?.student?.firstName ?? 'Darrion'} ${data?.studentSession?.student?.lastName ?? 'Kassulke'}', style: const pw.TextStyle(fontSize: 14))),
              ]),
              pw.Row(children: [
                pw.Text('Roll No: ', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic)),
                pw.Container(width: 150,
                  decoration: const pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black, style: pw.BorderStyle.dotted,),)),
                  child: pw.Text(data?.studentSession?.roll ?? '123', style: const pw.TextStyle(fontSize: 14),)),
              ]),]),

            pw.SizedBox(height: 40),


            pw.Text('has completed two years course of study at ${institute?.schoolName ?? 'Demo Collage 11'} with perfect attendance. We consider this to be a sign of his honesty, sincerity, responsibility, hard work and strong determination to do well.',
                style: pw.TextStyle(fontSize: 14, fontStyle: pw.FontStyle.italic, height: 1.5), textAlign: pw.TextAlign.justify),

            pw.SizedBox(height: 60),

            pw.Text('Congratulations.', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic)),

            pw.Spacer(),


            pw.Align(alignment: pw.Alignment.centerRight,
              child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
                pw.Container(width: 120, height: 60,
                  decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey))),
                pw.SizedBox(height: 8),
                pw.Text('------------------------------', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Container(width: 120, decoration: const pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black, style: pw.BorderStyle.dotted))),
                  child: pw.Text('Principal', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center)),
              ])),
          ]),
        ));
        },
      ),
    );

    return Uint8List.fromList(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Attendance Certificate PDF")),
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
