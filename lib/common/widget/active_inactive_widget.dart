import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/util/styles.dart';

class ActiveInActiveWidget extends StatelessWidget {
  final bool active;

  const ActiveInActiveWidget({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: active? Colors.green.withValues(alpha: .1) : Colors.red.withValues(alpha: .1),

      ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(active? Icons.check_circle : Icons.clear_rounded, color: active? Colors.green : Colors.red, size: 12,),
            const SizedBox(width: 5),
            Text("active", style: textRegular.copyWith(color:  active? Colors.green : Colors.red,),)
          ],),
        ),
      ),
    );
  }
}

class AttendanceStatusWidget extends StatelessWidget {
  final bool active;
  final String status;
  const AttendanceStatusWidget({super.key, required this.active, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: active? Colors.green : Colors.red,

      ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
          child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
            if(active)
            const Icon(Icons.check_circle, color: Colors.white, size: 15,),
            const SizedBox(width: 5),
            Text(status.tr, style: textRegular.copyWith(color:  Colors.white),)
          ],),
        ),
      ),
    );
  }
}