import '../../resources/exports/index.dart';

class UserPoints {
  RxInt? awardedPoints;
  RxInt? redeemedPoints;
  int? pointsToPkr;

  UserPoints({
    this.awardedPoints,
    this.redeemedPoints,
    this.pointsToPkr,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'awarded_points': awardedPoints,
      'redeemed_points': redeemedPoints,
      'points_to_pkr': pointsToPkr,
    };
  }

  factory UserPoints.fromMap(Map<String, dynamic> map) {
    return UserPoints(
      awardedPoints: (map['awarded_points'] as int? ?? 0).obs,
      redeemedPoints: (map['redeemed_points'] as int? ?? 0).obs,
      pointsToPkr: map['points_to_pkr'] as int? ?? 0,
    );
  }
}
