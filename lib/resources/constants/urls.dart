// ignore_for_file: constant_identifier_names

part of 'constants.dart';

class Urls {
  static const int PAGESIZE = 50;

// Home
  static const String LOGIN = '/api/v1/login';
  static const String SEND_OTP = '/api/v1/sent-otp';
  static const String VERIFY_OTP = '/api/v1/verify-otp';
  static const String FORGET_PASSWORD = '/api/v1/forget-password';
  static const String RESET_PASSWORD = '/api/v1/reset-password';
  static const String ACCOUNTS = '/api/v1/accounts';
  static const String AWARD_HISTORY = '/api/v1/award-history';
  static const String REDEEM_HISTORY = '/api/v1/redeem-history';
  static const String UPDATE_PROFILE = '/api/v1/user';
  static const String CHANGE_PASSWORD = '/api/v1/change-password';
  static const String SELECT_ACCOUNT = '/api/v1/select-account';
  static const String REDEEM = '/api/v1/redeem';
}
