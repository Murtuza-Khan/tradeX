import '../../../resources/exports/index.dart';

enum Filters {
  all(id: 0, title: Strings.SENDER_NAME);

  final int? id;
  final String? title;

  const Filters({this.id, this.title});

  static Filters getFilterType(int? id) {
    return Filters.values.firstWhere(
      (e) => e.id == id,
      orElse: () => Filters.all,
    );
  }
}
