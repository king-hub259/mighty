import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/hrm/logic/hrm_controller.dart';
import 'package:mighty_school/util/dimensions.dart';

class HrmScreen extends StatefulWidget {
  const HrmScreen({super.key});

  @override
  State<HrmScreen> createState() => _HrmScreenState();
}

class _HrmScreenState extends State<HrmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "hrm_management".tr,),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: GetBuilder<HrmController>(
            builder: (hrmController) {
              return Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                child: ListView.builder(
                    itemCount: hrmController.hrmDepartmentList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index){
                      return InkWell(onTap: (){
                        Get.to(hrmController.hrmDepartmentList[index].widget);
                      },
                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [
                              SizedBox(width: 30, child: Image.asset(hrmController.hrmDepartmentList[index].icon)),
                              const SizedBox(width: Dimensions.paddingSizeDefault),
                              Expanded(child: Text(hrmController.hrmDepartmentList[index].title.tr)),
                              Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Theme.of(context).hintColor)
                            ],
                            ),
                            const SizedBox(height: 10,),
                            Padding(padding: const EdgeInsets.fromLTRB(0,10,25.0,10),
                              child: Container(width: Get.width, height: .25, color: Theme.of(context).hintColor,),
                            )
                          ],
                          ),
                        ),
                      );
                    }),
              );
            }
        ),)
      ],)
    );
  }
}
