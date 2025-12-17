import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/sidebar/controller/side_menu_bar_controller.dart';
import 'package:mighty_school/util/styles.dart';

class AnnouncementScreen extends StatelessWidget {

  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: const BoxDecoration(),
        child: Row(children: [
          const Expanded(child: Text("Free Trail 5 days Left", style: textRegular,)),
            Container( width: 40, padding: const EdgeInsets.all(10),
              child: Center(
                child: InkWell(onTap: () => Get.find<SideMenuBarController>().changeAnnouncementOnOff(),
                    child: const Icon(Icons.clear)),
              ),
            ),
          ],
        ));
  }
}
