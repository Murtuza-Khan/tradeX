part of 'extensions.dart';

extension StringToColor on String {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  Color fromHex() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool hashSign = false, bool withAlpha = false}) {
    final alpha = (a * 255).toInt().toRadixString(16).padLeft(2, '0');
    final red = (r * 255).toInt().toRadixString(16).padLeft(2, '0');
    final green = (g * 255).toInt().toRadixString(16).padLeft(2, '0');
    final blue = (b * 255).toInt().toRadixString(16).padLeft(2, '0');

    return '${hashSign ? '#' : ''}'
            '${withAlpha ? alpha : ''}'
            '$red$green$blue'
        .toUpperCase();
  }

  int get getColorHex {
    return (a.toInt() << 24) | (r.toInt() << 16) | (g.toInt() << 8) | b.toInt();
  }

  Color light({double amount = 0.56}) {
    HSLColor hsl = HSLColor.fromColor(this);
    HSLColor lighterHsl =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lighterHsl.toColor();
  }

  static String colorToHex(Color? color) {
    if (color == null) return "0xFFFFFFFF";
    return color.toHex();
  }

  static Color fromHex(String? hexString) {
    if ((hexString ?? "").isEmpty) return Color(0xFFFFFFFF);
    if ((hexString ?? "").startsWith("0x")) {
      (hexString ?? "").substring(2);
    }
    final buffer = StringBuffer();
    if ((hexString ?? "").length == 6 || (hexString ?? "").length == 7) {
      buffer.write('ff');
    }
    buffer.write((hexString ?? "").replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
