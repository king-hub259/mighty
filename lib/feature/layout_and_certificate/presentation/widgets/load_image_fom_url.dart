import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;

Future<pw.ImageProvider> loadNetworkImage(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final contentType = response.headers['content-type'];

    Uint8List imageBytes = response.bodyBytes;

    if (contentType != null && !contentType.contains('png') && !contentType.contains('jpeg')) {
      // Convert unsupported formats (e.g. webp, gif) to PNG
      final decoded = img.decodeImage(imageBytes);
      if (decoded != null) {
        imageBytes = Uint8List.fromList(img.encodePng(decoded));
      } else {
        throw Exception("Unsupported or corrupted image format");
      }
    }

    return pw.MemoryImage(imageBytes);
  } else {
    throw Exception('Failed to load image from $url');
  }
}
