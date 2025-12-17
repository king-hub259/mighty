import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/images.dart';
import 'package:url_launcher/url_launcher.dart';

class CallWidget extends StatelessWidget {
  const CallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap:() async
    {
      launchUrl(Uri.parse("tel://${AppConstants.whatsAppNumber}"));
    },
      child: CustomContainer( color: Theme.of(context).secondaryHeaderColor, verticalPadding: 7, horizontalPadding: 7,
        borderRadius: 120,
        child: Row(children: [
          Image.asset(Images.call, width: 18),

        ],
        ),
      ),
    );
  }
}
