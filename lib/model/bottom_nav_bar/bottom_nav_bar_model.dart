import '../../resources/exports/index.dart';

class BottomNavBarModel {
  int id;
  String title;
  dynamic icon;
  bool isVisible;
  VoidCallback onTap;
  bool showDivider;

  BottomNavBarModel({
    required this.id,
    required this.title,
    required this.onTap,
    this.icon,
    this.isVisible = false,
    this.showDivider = false,
  });
}
