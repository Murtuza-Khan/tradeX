import '../../resources/exports/index.dart';

class Session {
  String? token;
  UserModel? user;
  AppColorsModel? appColors;
  CompaniesModel? company;

  Session({this.user, this.token, this.company, this.appColors});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user': user?.toJson(),
      'company': company?.toMap(),
      'token': token,
      'app_colors': appColors?.toMap(),
    };
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'] as String?,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      company: json['company'] != null
          ? CompaniesModel.fromMap(json['company'] as Map<String, dynamic>)
          : null,
      appColors: json['app_colors'] != null
          ? AppColorsModel.fromMap(json['app_colors'] as Map<String, dynamic>)
          : null,
    );
  }

  Session copyWith({
    String? token,
    UserModel? user,
    CompaniesModel? company,
    AppColorsModel? appColors,
  }) =>
      Session(
        token: token ?? this.token,
        user: user ?? this.user,
        company: company ?? this.company,
        appColors: appColors ?? this.appColors,
      );

  @override
  String toString() => 'Session(token: $token, user: $user, company: $company, appColors: $appColors)';
}
