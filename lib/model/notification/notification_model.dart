class NotificationModel {
  String? id;
  String? title;
  String? message;
  bool? isSeen;
  DateTime? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.isSeen,
    this.createdAt,
  });

  static List<NotificationModel> listFromJson(List jsonList) {
    return jsonList.map((e) => NotificationModel.fromMap(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(
      List<NotificationModel> jsonList) {
    return jsonList.map((e) => e.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
      'is_seen': isSeen,
      'created_at': createdAt,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String?,
      title: map['title'] as String?,
      message: map['message'] as String?,
      isSeen: map['is_seen'] as bool?,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }
}
