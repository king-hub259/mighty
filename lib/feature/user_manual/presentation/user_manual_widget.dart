import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/user_manual/domain/models/user_guide_model.dart';

class UserManualWidget extends StatelessWidget {
  const UserManualWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userGuideItems.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (_, index){
        final item = userGuideItems[index];
        return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          child: ListTile(title: Text(item.title), subtitle: Text(item.description),
              onTap: () => Get.toNamed(item.routeName)),
        );
      });
  }
}

