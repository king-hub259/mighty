import 'package:mighty_school/util/images.dart';

class KeyFeatureModel{
  final String title;
  final String description;
  final String imagePath;

  KeyFeatureModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

}

List<KeyFeatureModel> keyFeatures = [
  KeyFeatureModel(
    title: "User-Friendly Dashboard",
    description: "Simplified navigation for easy access to all tools.",
    imagePath: Images.dashboard,
  ),
  KeyFeatureModel(
    title: "AI-Powered Insights",
    description: " Smart analytics for better decision-making.",
    imagePath: Images.aiPower,
  ),
  KeyFeatureModel(
    title: "Multi-User Roles & Permissions",
    description: "Custom access levels for admins, teachers & parents",
    imagePath: Images.multiUser,
  ),
  KeyFeatureModel(
    title: "Cloud-Based & Secure",
    description: "Safe data storage with 24/7 accessibility.",
    imagePath: Images.cloudSecure,
  )
];