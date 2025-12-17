
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/package_plan/controller/package_controller.dart';
import 'package:mighty_school/feature/package_plan/presentation/widgets/subscription_item.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/feature/package_plan/domain/models/package_model.dart';


class SubscriptionPackageWidget extends StatelessWidget {
  const SubscriptionPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
        initState: (val) => Get.find<PackageController>().getPackageList(1),
        builder: (packageController) {
          PackageModel? package = packageController.packageModel;
          return package != null?
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(spacing:  Dimensions.paddingSizeDefault, children: [
              MasonryGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: package.data?.data?.length??0,
                  crossAxisCount: MediaQuery.sizeOf(context).width>1000? 3 : 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemBuilder: (context, index){
                    PackageItem? packageItem = package.data?.data?[index];
                    return SubscriptionItem(index: index, packageItem: packageItem);
                  }),

            ],),
          ): const SizedBox();
        }
    );
  }
}
