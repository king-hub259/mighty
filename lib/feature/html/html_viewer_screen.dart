import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/enums/enums.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/footer/footer_base_view.dart';
import 'package:mighty_school/common/widget/web_shadow_wrap.dart';
import 'package:mighty_school/feature/html/controller/webview_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';


class HtmlViewerScreen extends StatefulWidget {
  final HtmlType? htmlType;
  const HtmlViewerScreen({super.key, @required this.htmlType});

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}

class _HtmlViewerScreenState extends State<HtmlViewerScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<HtmlViewController>().getPagesContent();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: CustomAppBar(title: widget.htmlType == HtmlType.termsAndCondition ? 'terms_and_conditions'.tr
          : widget.htmlType == HtmlType.aboutUs ? 'about_us'.tr :
      widget.htmlType == HtmlType.privacyPolicy ? 'privacy_policy'.tr :
      widget.htmlType == HtmlType.cancellationPolicy ? 'cancellation_policy'.tr :
      widget.htmlType == HtmlType.refundPolicy ? 'refund_policy'.tr :
      'no_data_found'.tr),


      body: GetBuilder<HtmlViewController>(
        builder: (htmlViewController){
          String? data;
          if(htmlViewController.pagesContent != null){
             data = widget.htmlType == HtmlType.termsAndCondition ? htmlViewController.pagesContent?.termsAndConditions?.liveValues??""
                : widget.htmlType == HtmlType.aboutUs ? htmlViewController.pagesContent?.aboutUs?.liveValues??""
                : widget.htmlType == HtmlType.privacyPolicy ? htmlViewController.pagesContent?.privacyPolicy?.liveValues ?? ""
                : widget.htmlType == HtmlType.refundPolicy ? htmlViewController.pagesContent?.refundPolicy?.liveValues ?? ""
                : widget.htmlType == HtmlType.cancellationPolicy ? htmlViewController.pagesContent?.cancellationPolicy?.liveValues??""
                : null;

               if(data != null) {
                 data = data.replaceAll('href=', 'target="_blank" href=');

               return FooterBaseView(
                 isScrollView:ResponsiveHelper.isMobile(context) ? false: true,
                 isCenter:true,
                 child: WebShadowWrap(
                   child: SizedBox(width: Dimensions.webMaxWidth, height: Get.height,
                     child:SingleChildScrollView(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                       physics: const BouncingScrollPhysics(),
                       child: Column(children: [
                          if( ResponsiveHelper.isDesktop(context))
                           Padding(padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                             child: Text(
                               widget.htmlType == HtmlType.termsAndCondition ? 'terms_and_conditions'.tr
                                   : widget.htmlType == HtmlType.aboutUs ? 'about_us'.tr :
                               widget.htmlType == HtmlType.privacyPolicy ? 'privacy_policy'.tr :
                               widget.htmlType == HtmlType.cancellationPolicy ? 'cancellation_policy'.tr :
                               widget.htmlType == HtmlType.refundPolicy ? 'refund_policy'.tr:'',
                               style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
                           Html(data: data, style: {"p": Style(fontSize: FontSize.medium)}),
                         ],
                       ),
                     ),
                   ),
                 ),
               );
             }else{
               return const SizedBox();
             }
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        hoverColor:Colors.black26,
        onPressed:  (){

        },
        child: Center(child:  Image.asset(Images.logo,scale: 2.8,)),
      ),
    );
  }
}
