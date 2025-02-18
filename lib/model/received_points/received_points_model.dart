import '../../resources/exports/index.dart';

class ReceivedPointsModel {
  int? awardedPoints;
  int? redeemedPoints;
  String? logo;
  String? banner;
  AppColorsModel? appColors;
  List<ReceivedPointsDataModel>? receivedPoints;

  ReceivedPointsModel({
    this.awardedPoints,
    this.redeemedPoints,
    this.logo,
    this.banner,
    this.receivedPoints,
    this.appColors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'awarded_points': awardedPoints,
      'logo': logo,
      'banner': banner,
      'redeemed_points': redeemedPoints,
      'app_colors': appColors?.toMap(),
      'received_points': ReceivedPointsDataModel.listToJson(
        receivedPoints ?? [],
      ),
    };
  }

  factory ReceivedPointsModel.fromMap(Map<String, dynamic> map) {
    return ReceivedPointsModel(
      awardedPoints: map['awarded_points'] as int?,
      redeemedPoints: map['redeemed_points'] as int?,
      logo: map['logo'] as String?,
      banner: map['banner'] as String?,
      receivedPoints: ReceivedPointsDataModel.listFromJson(
        map['received_points'] ?? [],
      ),
      appColors: map['app_colors'] != null
          ? AppColorsModel.fromMap(map['app_colors'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ReceivedPointsDataModel {
  int? id;
  int? points;
  String? from;
  DateTime? dateTime;

  ReceivedPointsDataModel({
    this.id,
    this.points,
    this.from,
    this.dateTime,
  });

  static List<ReceivedPointsDataModel> listFromJson(List jsonList) {
    return jsonList.map((e) => ReceivedPointsDataModel.fromMap(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(
      List<ReceivedPointsDataModel> jsonList) {
    return jsonList.map((e) => e.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'points': points,
      'from': from,
      'date_time': dateTime,
    };
  }

  factory ReceivedPointsDataModel.fromMap(Map<String, dynamic> map) {
    return ReceivedPointsDataModel(
      id: map['id'] as int?,
      points: map['points'] as int?,
      from: map['from'] as String?,
      dateTime: map['date_time'] != null
          ? DateTime.parse((map['date_time']).toString().split('.')[0])
          : null,
    );
  }
}
