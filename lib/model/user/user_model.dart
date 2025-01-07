class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? countrycode;
  String? phone;
  String? cnic;

  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.countrycode,
    this.phone,
    this.cnic,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'country_code': countrycode,
      'phone': phone,
      'cnic': cnic,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      countrycode: json['country_code'] as String?,
      phone: json['phone'] as String?,
      cnic: json['cnic'] as String?,
    );
  }

  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? countrycode,
    String? phone,
    String? cnic,
  }) {
    return UserModel(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      countrycode: countrycode ?? this.countrycode,
      phone: phone ?? this.phone,
      cnic: cnic ?? this.cnic,
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, firstName: $firstName, lastName: $lastName, countrycode: $countrycode, phone: $phone, cnic: $cnic)';
  }
}
