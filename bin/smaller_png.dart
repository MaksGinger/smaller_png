import 'dart:io';

import 'package:args/args.dart';
import 'package:smaller_png/color_depth.dart';
import 'package:smaller_png/compress_png.dart';

const inputOptionName = 'input';
const outputOptionName = 'output';
const colorsOptionName = 'colors';

int main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption(
      inputOptionName,
      abbr: 'i',
      help: 'Input PNG-file path',
    )
    ..addOption(
      outputOptionName,
      abbr: 'o',
      help: 'Path to save compressed PNG-file',
    )
    ..addOption(
      colorsOptionName,
      abbr: 'c',
      help: 'Number of colors to quantize',
      allowed: ['256', '128', '64', '32', '16'],
      defaultsTo: '256',
    );
  try {
    final argResults = parser.parse(arguments);

    final inputPath = argResults['input'];
    final outputPath = argResults['output'];
    final colorsStr = argResults['colors'];

    if (inputPath == null || outputPath == null) {
      stderr.writeln('Input and Output file paths must be specified.');
      print('\nUsage:');
      print(parser.usage);
      return 1;
    }

    final colorDepth = ColorDepth.fromString(colorsStr);

    compressPng(
      inputFilePath: inputPath,
      outputFilePath: outputPath,
      colorDepth: colorDepth,
    );

    return 0;
  } catch (e) {
    stderr.writeln(
      'Unexpected exception when compressing PNG image.\n'
      'Details: $e',
    );
    print('\nUsage:');
    print(parser.usage);
    return 1;
  }
}
