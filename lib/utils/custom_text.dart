import '../resources/exports/index.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      (text ?? "").tr,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
