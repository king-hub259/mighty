import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/parent_module/children/domain/model/children_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ChildrenItemWidget extends StatelessWidget {
  final ChildrenItem? childrenItem;
  final int index;
  const ChildrenItemWidget({super.key, this.childrenItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: CustomContainer(color: Theme.of(context).cardColor,

        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Text('${childrenItem?.firstName} ${childrenItem?.lastName}', style: textRegular.copyWith(),),
              Text('${childrenItem?.className}', style: textRegular.copyWith(),),

            ],),
          ),
        ],
        ),
      ),
    );
  }
}
