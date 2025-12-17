import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class NewsLetterWidget extends StatelessWidget {
  const NewsLetterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 22),
        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).hintColor, width: 1),
            borderRadius: BorderRadius.circular(15), color: Theme.of(context).colorScheme.primary),
        child: Column(children: [
          Text("stay_updated".tr, style: textBold.copyWith(color: Theme.of(context).scaffoldBackgroundColor, fontSize: 20  ),),
          Text("sign_up_newsletter".tr, style: textRegular.copyWith(color: Theme.of(context).scaffoldBackgroundColor, fontSize: 16  ),),
          const SizedBox(height: 30),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "your_email".tr,
              hintStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: const Color(0xFF1E294A), // Dark blue background
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF2A3557), width: 1.5), // Border color and width
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white70, width: 1.5), // Border when focused
              ),
              suffixIcon: const Icon(Icons.mail_outline, color: Colors.white70),
            ),
          ),
          const SizedBox(height: 25),
          CustomButton(onTap: (){}, text: "subscribe".tr)
        ],
        ),
      ),
    );
  }
}
