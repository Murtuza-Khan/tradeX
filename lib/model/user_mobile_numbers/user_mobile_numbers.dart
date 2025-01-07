class UserMobileNumbers {
  String? mobile;
  String? countryCode;
  bool isSelected;

  UserMobileNumbers({
    this.mobile,
    this.countryCode,
    this.isSelected = false,
  });

  static List<UserMobileNumbers> listFromJson(List jsonList) {
    return jsonList.map((e) => UserMobileNumbers.fromMap(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(
    List<UserMobileNumbers> jsonList,
  ) {
    return jsonList.map((e) => e.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mobile': mobile,
      'country_code': countryCode,
    };
  }

  factory UserMobileNumbers.fromMap(Map<String, dynamic> map) {
    return UserMobileNumbers(
      mobile: map['mobile'] as String?,
      countryCode: map['country_code'] as String?,
      isSelected: false,
    );
  }
}
