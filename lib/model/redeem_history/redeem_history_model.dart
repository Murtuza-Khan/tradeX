class RedeemHistory {
  int? id;
  DateTime? createdDate;
  int? points;
  String? voucherCode;

  RedeemHistory({
    this.id,
    this.createdDate,
    this.points,
    this.voucherCode,
  });

  static List<RedeemHistory> listFromJson(List jsonList) {
    return jsonList.map((e) => RedeemHistory.fromMap(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<RedeemHistory> jsonList) {
    return jsonList.map((e) => e.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date_time': createdDate.toString(),
      'points': points,
      'voucher_code': voucherCode,
    };
  }

  factory RedeemHistory.fromMap(Map<String, dynamic> map) {
    return RedeemHistory(
      id: map['id'] as int?,
      createdDate: map['date_time'] != null
          ? DateTime.parse(map['date_time'])
          : null,
      points: map['points'] as int?,
      voucherCode: map['voucher_code'] as String?,
    );
  }
}
