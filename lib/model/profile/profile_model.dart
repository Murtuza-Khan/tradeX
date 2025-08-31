class ProfileModel {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? profileImage;

  ProfileModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      userId: map['id'] as int?,
      firstName: map['first_name'] as String?,
      lastName: map['last_name'] as String?,
      email: map['email'] as String?,
      phone: map['mobile'] as String?,
      profileImage: map['profile_image'] as String?,
    );
  }
}
