import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/load_image_fom_url.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TestimonialPdfPreviewPage extends StatelessWidget {
  const TestimonialPdfPreviewPage({super.key});

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    final controller = Get.find<LayoutAndCertificateController>();
    final systemController = Get.find<SystemSettingsController>();
    final data = controller.layoutAndCertificateModel?.data;
    var institute = systemController.generalSettingModel?.data;
    final logoImage = await loadNetworkImage(systemController.logoUrl);

    pdf.addPage(pw.Page(pageFormat: format, margin: pw.EdgeInsets.zero, build: (pw.Context context) {
      return pw.Container(decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black, width: 2),

        boxShadow: const [pw.BoxShadow(color: PdfColors.grey, blurRadius: 2)]),
        padding: const pw.EdgeInsets.all(24),
        child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: [

          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Text(institute?.schoolName ?? 'N/A', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(institute?.address ?? 'Asia, Dhaka'),
              pw.Text('Tel:${institute?.phone ??'N/A'}'),
              pw.Text(institute?.eiinCode ??'N/A'),
            ]),
            pw.Image(logoImage, width: 80),
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Text(institute?.schoolName ?? 'N/A', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(institute?.address ?? 'Asia, Dhaka'),
              pw.Text('Tel:${institute?.phone ??'N/A'}'),
              pw.Text(institute?.eiinCode ??'N/A'),
            ])]),

          pw.SizedBox(height: 10),
          pw.Divider(thickness: 2),
          pw.Align(alignment: pw.Alignment.centerRight, child: pw.Text('Date: ${AppConstants.currentDate}')),
          pw.SizedBox(height: 16),
          pw.Center(child: pw.Text('Testimonial',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline))),
          pw.SizedBox(height: 16),


          pw.Text('This is to certify that ${data?.studentSession?.student?.firstName} ${data?.studentSession?.student?.lastName}  '
              '( Roll # ${data?.studentSession?.roll??'N/A'} ), son of ${data?.studentSession?.student?.fatherName??'N/A'} '
              'and ${data?.studentSession?.student?.motherName??'N/A'} '
              'from ---------------------------- District, ------------------------, was a student of ${institute?.schoolName} in '
              '${data?.studentSession?.classItem?.className??'n?a'} ${data?.studentSession?.student?.studentGroup?.groupName} '
              'from  ---------------------------- to  ----------------------------. '
              'He appeared for the Higher Secondary Certificate Examinations of the ---------------------, ----------------------------- '
              'of Intermediate and Secondary Education in the year ---------------------------- as a candidate from this college '
              'bearing Board Roll No ---------------------- Registration No ------------------------ Session -----------------------and '
              'passed with GPA ---------------------------- on a scale of 5.00.',
                  style: const pw.TextStyle(fontSize: 11, height: 1.5)),
                pw.SizedBox(height: 12),
                pw.Text('His combination of Subjects was:----------------------------',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8),

                pw.Text('........................................................................................................',
                  style: const pw.TextStyle(fontSize: 11)),
                pw.SizedBox(height: 16),
                pw.Text('It is also certified that to the best of my knowledge he has a good moral character, '
                      'and while at this college he was not a source of indiscipline.',
                  style: const pw.TextStyle(fontSize: 11)),
                pw.SizedBox(height: 30),

                // Signature Area
                pw.Align(alignment: pw.Alignment.centerRight,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Sincerely'),
                      pw.SizedBox(height: 40),
                      pw.Text('----------------------------'),
                      pw.Text('Principal'),
                      pw.Text(institute?.schoolName ?? 'N/A'),
                    ],
                  ),
                ),
              ],
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
      appBar: AppBar(title: const Text("Preview Testimonial PDF")),
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
