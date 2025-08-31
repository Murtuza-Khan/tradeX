import '../resources/exports/index.dart';

class CustomRichText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final List<InlineSpan>? children;

  const CustomRichText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: (text ?? "").tr, style: style, children: children),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
