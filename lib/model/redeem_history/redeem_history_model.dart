class RedeemHistory {
  int? id;
  String? requestId;
  DateTime? createdDate;
  int? points;
  String? voucherCode;

  RedeemHistory({
    this.id,
    this.requestId,
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
      'request_id': requestId,
      'created_date': createdDate.toString(),
      'points': points,
      'voucher_code': voucherCode,
    };
  }

  factory RedeemHistory.fromMap(Map<String, dynamic> map) {
    return RedeemHistory(
      id: map['id'] as int?,
      requestId: map['request_id'] as String?,
      createdDate: map['created_date'] != null
          ? DateTime.parse(map['created_date'])
          : null,
      points: map['points'] as int?,
      voucherCode: map['voucher_code'] as String?,
    );
  }
}
