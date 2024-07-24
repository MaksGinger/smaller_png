enum ColorDepth {
  colors256(256),
  colors128(128),
  colors64(64),
  colors32(32),
  colors16(16);

  final int value;

  const ColorDepth(this.value);

  static ColorDepth fromString(String str) {
    return switch (str) {
      '256' => ColorDepth.colors256,
      '128' => ColorDepth.colors128,
      '64' => ColorDepth.colors64,
      '32' => ColorDepth.colors32,
      '16' => ColorDepth.colors16,
      _ => ColorDepth.colors256,
    };
  }
}
