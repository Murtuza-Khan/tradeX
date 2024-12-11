import '../../resources/exports/index.dart';

class UserModel {
  int? status;
  String? gender;
  String? city;
  String? email;
  UserVerificationStatus? emailVerified;
  int? active;
  String? firstName;
  String? lastName;
  String? countrycode;
  String? phone;
  int? phoneVerified;
  int? signupDiscountUsed;
  int? gkPoints;

  UserModel({
    this.status,
    this.gender,
    this.city,
    this.email,
    this.emailVerified,
    this.active,
    this.firstName,
    this.lastName,
    this.countrycode,
    this.phone,
    this.phoneVerified,
    this.signupDiscountUsed,
    this.gkPoints,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'gender': gender,
      'city': city,
      'email': email,
      'email_verified': emailVerified?.id,
      'active': active,
      'first_name': firstName,
      'last_name': lastName,
      'country_code': countrycode,
      'phone': phone,
      'phone_verified': phoneVerified,
      'signup_discount_used': signupDiscountUsed,
      'gk_points': gkPoints,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'] as int?,
      gender: json['gender'] as String?,
      city: json['city'] as String?,
      email: json['email'] as String?,
      emailVerified: UserVerificationStatus.getStatus(
        json['email_verified'] as int?,
      ),
      active: json['active'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      countrycode: json['country_code'] as String?,
      phone: json['phone'] as String?,
      phoneVerified: json['phone_verified'] as int?,
      signupDiscountUsed: json['signup_discount_used'] as int?,
      gkPoints: json['gk_points'] as int?,
    );
  }

  UserModel copyWith({
    int? status,
    String? gender,
    String? city,
    String? email,
    UserVerificationStatus? emailVerified,
    int? active,
    String? firstName,
    String? lastName,
    String? countrycode,
    String? phone,
    int? phoneVerified,
    int? signupDiscountUsed,
    int? gkPoints,
  }) {
    return UserModel(
      status: status ?? this.status,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      active: active ?? this.active,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      countrycode: countrycode ?? this.countrycode,
      phone: phone ?? this.phone,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      signupDiscountUsed: signupDiscountUsed ?? this.signupDiscountUsed,
      gkPoints: gkPoints ?? this.gkPoints,
    );
  }

  @override
  String toString() {
    return 'UserModel(status: $status, gender: $gender, city: $city, email: $email, email_verified: $emailVerified, active: $active, first_name: $firstName, last_name: $lastName, country_code: $countrycode, phone: $phone, phone_verified: $phoneVerified, signup_discount_used: $signupDiscountUsed, gk_points: $gkPoints)';
  }
}
