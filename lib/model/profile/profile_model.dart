class ProfileModel {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phone;

  ProfileModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'country_code': countryCode,
      'phone': phone,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      userId: map['user_id'] as int?,
      firstName: map['first_name'] as String?,
      lastName: map['last_name'] as String?,
      email: map['email'] as String?,
      countryCode: map['country_code'] as String?,
      phone: map['phone'] as String?,
    );
  }
}
