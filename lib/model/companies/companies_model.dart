class CompaniesModel {
  int? id;
  String? name;
  int? points;
  bool? isSelected;
  bool? isPhoneVerified;
  String? countryCode;
  String? phone;

  CompaniesModel({
    this.id,
    this.name,
    this.points,
    this.isSelected,
    this.isPhoneVerified,
    this.countryCode,
    this.phone,
  });

  static List<CompaniesModel> listFromJson(List jsonList) {
    return jsonList.map((e) => CompaniesModel.fromMap(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<CompaniesModel> jsonList) {
    return jsonList.map((e) => e.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'points': points,
      'is_selected': isSelected,
      'is_phone_verified': isPhoneVerified,
      'country_code': countryCode,
      'phone': phone,
    };
  }

  factory CompaniesModel.fromMap(Map<String, dynamic> map) {
    return CompaniesModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      points: map['points'] as int?,
      isSelected: map['is_selected'] as bool?,
      isPhoneVerified: map['is_phone_verified'] as bool?,
      countryCode: map['country_code'] as String?,
      phone: map['phone'] as String?,
    );
  }

  @override
  String toString() =>
      'CompaniesModel(id: $id, name: $name, points: $points, isSelected: $isSelected, is_phone_verified: $isPhoneVerified, country_code: $countryCode, phone: $phone)';

  CompaniesModel copyWith({
    int? id,
    String? name,
    int? points,
    bool? isSelected,
    bool? isPhoneVerified,
    String? countryCode,
    String? phone,
  }) {
    return CompaniesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      points: points ?? this.points,
      isSelected: isSelected ?? this.isSelected,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      countryCode: countryCode ?? this.countryCode,
      phone: phone ?? this.phone,
    );
  }
}
