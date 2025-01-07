import '../../../resources/exports/index.dart';

class SinWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.9)
      ..cubicTo(
        size.width * 0.35,
        size.height * 0.35,
        size.width * 0.75,
        size.height * 1.4,
        size.width,
        size.height * 0.75,
      )
      ..lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}