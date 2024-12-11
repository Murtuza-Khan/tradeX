import '../../resources/exports/index.dart';

class Session {
  String? token;
  UserModel? user;

  Session({this.user, this.token});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user': user?.toJson(),
      'token': token,
    };
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'] as String?,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Session copyWith({
    String? token,
    UserModel? user,
  }) =>
      Session(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  @override
  String toString() => 'Session(token: $token, user: $user)';
}
