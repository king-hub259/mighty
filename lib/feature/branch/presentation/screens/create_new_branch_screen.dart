import 'package:flutter/material.dart';
import 'package:mighty_school/feature/branch/domain/models/branch_model.dart';
import 'package:mighty_school/feature/branch/presentation/widgets/create_new_branch_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewBranchScreen extends StatefulWidget {
  final BranchItem? branchItem;
  const CreateNewBranchScreen({super.key, this.branchItem});

  @override
  State<CreateNewBranchScreen> createState() => _CreateNewBranchScreenState();
}

class _CreateNewBranchScreenState extends State<CreateNewBranchScreen> {

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: CreateNewBranchWidget(branchItem: widget.branchItem,),
    );
  }
}
