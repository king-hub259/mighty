import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/landing_page/domain/models/saas_faq_model.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class FaqWidget extends StatelessWidget {
  const FaqWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val) {
        if(Get.find<LandingPageController>().saasFaqModel == null){
          Get.find<LandingPageController>().getSaasFaqData();
        }
      },
      builder: (landingPageController) {
        SaasFaqModel? faqModel = landingPageController.saasFaqModel;
        return faqModel != null?
        SizedBox(width: Dimensions.webMaxWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context)?0 : Dimensions.paddingSizeDefault,),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("faq".tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: 20)),
              Text("have_question".tr, textAlign: TextAlign.center, style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraOverLarge, color: Theme.of(context).colorScheme.primary)),
              Container(height: 3, width: 60, decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(50))),
              const SizedBox( height: Dimensions.paddingSizeDefault),
              ListView.builder(
                  itemCount: faqModel.data?.data?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:  EdgeInsets.zero,
                  itemBuilder: (context, index){
                    return FaqItemWidget(item:faqModel.data?.data?[index], index: index);
                  })
            ],
            ),
          ),
        ):const SizedBox();
      }
    );
  }
}


class FaqItemWidget extends StatefulWidget {
  final SaasFaqItem? item;
  final int? index;
  final bool initiallyExpanded;

  const FaqItemWidget({super.key, this.item, this.initiallyExpanded = false, this.index});

  @override
  FaqItemWidgetState createState() => FaqItemWidgetState();
}

class FaqItemWidgetState extends State<FaqItemWidget> {
  late ValueNotifier<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = ValueNotifier<bool>(widget.initiallyExpanded);
  }

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Theme.of(context).hintColor.withValues(alpha: 0.1),
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ValueListenableBuilder<bool>(
          valueListenable: _isExpanded,
          builder: (context, expanded, child) {
            return ExpansionTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              backgroundColor: Theme.of(context).primaryColor,
              initiallyExpanded: widget.initiallyExpanded,
              title: Text("${widget.index!+1}. ${widget.item?.question??''}", style: textBold.copyWith(color: expanded? Theme.of(context).scaffoldBackgroundColor: Theme.of(context).colorScheme.primary)),
              trailing: Icon(expanded ? Icons.remove : Icons.add, color: expanded? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor,),
              onExpansionChanged: (value) {
                _isExpanded.value = value;
              }, children: [
                Align(alignment: Alignment.centerLeft,
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(widget.item?.answer??'', style: textRegular.copyWith(color: Theme.of(context).scaffoldBackgroundColor)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}