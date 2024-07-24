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

  final quantizedImage = quantize(image, numberOfColors: colorDepth.value);
  File(outputFilePath).writeAsBytesSync(encodePng(quantizedImage));

  print('Image was successfully compressed and saved to $outputFilePath');
}
