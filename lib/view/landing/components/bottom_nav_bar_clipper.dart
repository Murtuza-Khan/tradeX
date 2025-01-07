import '../../../resources/exports/index.dart';

class NavBarClipper extends CustomClipper<Path> {
  final int selectedIndex;
  NavBarClipper({required this.selectedIndex});

  @override
  Path getClip(Size size) {
    double singleItemWidth = (size.width / 3) * selectedIndex;
    double startingPoint = singleItemWidth + ((size.width / 3) / 2);
    final path = Path()
      ..moveTo(0, 0)
      ..moveTo(0, 32)
      ..lineTo(startingPoint - 38, 32)
      ..arcToPoint(
        Offset(startingPoint + 38, 32),
        clockwise: false,
        radius: const Radius.circular(30.0),
      )
      ..lineTo(size.width, 32)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..moveTo(0, 0);

    path.fillType = PathFillType.evenOdd;
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}
