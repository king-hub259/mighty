import 'package:flutter/material.dart';
import 'package:mighty_school/util/styles.dart';

import '../../domain/model/salary_slip_model.dart';


class SalarySlipItemTitleWidget extends StatelessWidget {
  final double width;
  final SalaryHeads head;
  const SalarySlipItemTitleWidget({super.key, required this.width, required this.head});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,
      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(head.name ?? "", style: textRegular.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center, maxLines: 1,
              overflow: TextOverflow.ellipsis),
            Text((head.type == "Addition") ? "(+)" : "(-)",
              style: textRegular.copyWith(color: (head.type == "Addition") ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
