enum SendOtpOn { email, phone }

enum UserVerificationStatus {
  verified(id: 1, value: 'Verified'),
  notVerified(id: 0, value: 'Not Verified');

  final int? id;
  final String? value;

  const UserVerificationStatus({this.id, this.value});

  static getStatus(int? id) {
    return UserVerificationStatus.values.firstWhere(
      (element) => element.id == id,
      orElse: () => UserVerificationStatus.notVerified,
    );
  }
}

enum SignupDiscountStatus {
  notUsed(id: 0, value: 'Not Used'),
  used(id: 1, value: 'Used');

  final int? id;
  final String? value;

  const SignupDiscountStatus({this.id, this.value});

  static SignupDiscountStatus getStatus(int? id) {
    return SignupDiscountStatus.values.firstWhere(
      (element) => element.id == id,
      orElse: () => SignupDiscountStatus.used,
    );
  }
}

enum LoginStatus {
  inActive(id: 0, value: 'In Active'),
  active(id: 1, value: 'Active');

  final int? id;
  final String? value;

  const LoginStatus({this.id, this.value});

  static LoginStatus getStatus(int? id) {
    return LoginStatus.values.firstWhere(
      (element) => element.id == id,
      orElse: () => LoginStatus.active,
    );
  }
}
