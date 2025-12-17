import 'package:flutter/material.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/util/dimensions.dart';
class PaymentGatewaySettings extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final VoidCallback onToggle;
  final TextEditingController privateKeyController;
  final TextEditingController publicKeyController;
  final TextEditingController gatewayTitleController;

  const PaymentGatewaySettings({
    super.key,
    required this.title,
    required this.isEnabled,
    required this.onToggle,
    required this.privateKeyController,
    required this.publicKeyController,
    required this.gatewayTitleController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16.0),
      child: CustomContainer(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Switch(value: isEnabled, onChanged: (value) => onToggle())]),

            Container(height: 100, width: double.infinity, color: Colors.grey[200],
              child: const Icon(Icons.image, size: 40, color: Colors.grey)),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Mode"),
              items: const [
                DropdownMenuItem(value: "Live", child: Text("Live")),
                DropdownMenuItem(value: "Test", child: Text("Test")),
              ],
              onChanged: (value) {}),

            TextField(controller: privateKeyController, decoration: const InputDecoration(labelText: "Private Key *")),
            TextField(controller: publicKeyController, decoration: const InputDecoration(labelText: "Public Key *")),
            TextField(controller: gatewayTitleController, decoration: const InputDecoration(labelText: "Payment Gateway Title *")),
            OutlinedButton(onPressed: () {}, child: const Text("Choose File")),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {},
              child: const Text("Save"))),
          ],
        ),
      ),
    );
  }
}