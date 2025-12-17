import 'package:flutter/material.dart';
import 'package:mighty_school/feature/academic_configuration/session/domain/models/session_model.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/create_new_session_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewSessionScreen extends StatefulWidget {
  final SessionItem? sessionItem;
  const CreateNewSessionScreen({super.key, this.sessionItem});

  @override
  State<CreateNewSessionScreen> createState() => _CreateNewSessionScreenState();
}

class _CreateNewSessionScreenState extends State<CreateNewSessionScreen> {

  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: CreateNewSessionWidget(sessionItem: widget.sessionItem,),
      ),
    );
  }
}
