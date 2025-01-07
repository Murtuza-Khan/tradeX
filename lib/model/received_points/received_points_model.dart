class ReceivedPointsModel {
  int? totalPoints;
  int? redeemedPoints;
  List<ReceivedPointsDataModel>? receivedPoints;

  ReceivedPointsModel({
    this.totalPoints,
    this.redeemedPoints,
    this.receivedPoints,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'awarded_points': totalPoints,
      'redeemed_points': redeemedPoints,
      'received_points': ReceivedPointsDataModel.listToJson(
        receivedPoints ?? [],
      ),
    };
  }

  factory ReceivedPointsModel.fromMap(Map<String, dynamic> map) {
    return ReceivedPointsModel(
      totalPoints: map['awarded_points'] as int?,
      redeemedPoints: map['redeemed_points'] as int?,
      receivedPoints: ReceivedPointsDataModel.listFromJson(
        map['received_points'] ?? [],
      ),
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
      dateTime:
          map['date_time'] != null ? DateTime.parse(map['date_time']) : null,
    );
  }
}
