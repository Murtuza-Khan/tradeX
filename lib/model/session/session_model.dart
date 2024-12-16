import '../../resources/exports/index.dart';

class Session {
  String? token;
  UserModel? user;
  CompaniesModel? company;

  Session({this.user, this.token, this.company});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user': user?.toJson(),
      'company': company?.toMap(),
      'token': token,
    };
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'] as String?,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      company: json['company'] != null
          ? CompaniesModel.fromMap(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Session copyWith({
    String? token,
    UserModel? user,
    CompaniesModel? company,
  }) =>
      Session(
        token: token ?? this.token,
        user: user ?? this.user,
        company: company ?? this.company,
      );

  @override
  String toString() => 'Session(token: $token, user: $user, company: $company)';
}
