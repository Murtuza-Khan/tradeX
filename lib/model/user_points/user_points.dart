import '../../resources/exports/index.dart';

class UserPoints {
  RxInt? awardedPoints;
  RxInt? redeemedPoints;

  UserPoints({this.awardedPoints, this.redeemedPoints});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'awarded_points': awardedPoints,
      'redeemed_points': redeemedPoints,
    };
  }

  factory UserPoints.fromMap(Map<String, dynamic> map) {
    return UserPoints(
      awardedPoints: (map['awarded_points'] as int? ?? 0).obs,
      redeemedPoints: (map['redeemed_points'] as int? ?? 0).obs,
    );
  }
}
