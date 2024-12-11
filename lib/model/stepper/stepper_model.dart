import '../../resources/exports/index.dart';

class StepperModel {
  int id;
  IconData icon;
  String title;
  VoidCallback onTap;
  double padding;

  StepperModel({
    required this.id,
    required this.icon,
    required this.title,
    required this.onTap,
    this.padding = 70.0,
  });
}
