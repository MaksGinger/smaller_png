import 'dart:io';

import 'package:image/image.dart';
import 'package:smaller_png/color_depth.dart';

void compressPng({
  required String inputFilePath,
  required String outputFilePath,
  required ColorDepth colorDepth,
}) {
  final image = decodeImage(File(inputFilePath).readAsBytesSync());

  if (image == null) {
    throw Exception('Unable to load image: $inputFilePath');
  }

  final quantizedImage =
      quantizeImageWithAlpha(image, numberOfColors: colorDepth.value);
  File(outputFilePath).writeAsBytesSync(encodePng(quantizedImage));

  print('Image was successfully compressed and saved to $outputFilePath');
}

Image quantizeImageWithAlpha(Image srcImage, {required int numberOfColors}) {
  final width = srcImage.width;
  final height = srcImage.height;

  final indexedImage = Image(width: width, height: height, numChannels: 4);

  final quantized = quantize(srcImage, numberOfColors: numberOfColors);

  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final srcPixel = srcImage.getPixel(x, y);
      final quantizedPixel = quantized.getPixel(x, y);

      final r = quantizedPixel.r;
      final g = quantizedPixel.g;
      final b = quantizedPixel.b;
      final a = srcPixel.a;

      indexedImage.setPixelRgba(x, y, r, g, b, a);
    }
  }

  return indexedImage;
}
