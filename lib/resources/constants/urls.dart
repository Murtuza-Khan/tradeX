// ignore_for_file: constant_identifier_names

part of 'constants.dart';

class Urls {
// Home
  static const String NEWS = 'api/v3/news';
  static const String VOUCHERS = '/api/v3/vouchers';
  static const String CATEGORIES = '/api/v3/categories';
  static const String FEATURED_CATEGORIES = '/api/v3/featured_categories';
  static const String CITIES = '/api/v3/cities';
  static const String TEMPLATE_CATEGORIES = '/api/v3/templateCategories';
  static const String TEMPLATES_BY_CAT_ID = '/api/v3/templatesByCatId';
  static const String SLIDERS = '/api/v3/sliders';

// Authentication
  static const String SIGNIN = '/api/v3/signin';
  static const String SIGNUP = '/api/v3/signup';
  static const String SEND_OTP = '/api/v3/send_otp';
  static const String VERIFY_OTP = '/api/v3/verify_otp';
  static const String FORGET_PASSWORD = '/api/v3/forget_password';

// Side Menu
  static const String POINTS = '/api/v3/points';
  static const String CONTACT = '/api/v3/contact';
  static const String WHY = '/api/v3/why';
  static const String ABOUT = '/api/v3/about';
  static const String FAQ = '/api/v3/faq';
  static const String TERMS_AND_CONDITIONS = '/api/v3/terms_conditions';
  static const String PRIVACY_POLICY = '/api/v3/privacy_policy';
  static const String DISCLAIMER = '/api/v3/disclaimer';
  static const String PROFILE = '/api/v3/profile';
  static const String PROFILE_DELETE = '/api/v3/profile_delete';
  static const String GIFTS_SENT = '/api/v3/gifts_sent';
  static const String GIFTS_RECEIVED = '/api/v3/gifts_received';
  static const String PDF_DOWNLOAD = '/api/v3/pdf_download';
  static const String PRE_ACTIVATION = '/api/v3/pre_activation';
  static const String POST_ACTIVATION = '/api/v3/post_activation';

// Checkout v
  static const String PAY_HAND_SHAKE_GIFT = '/api/v3/payHandshakeGift';
  static const String ORDER_STATUS = '/api/v3/order_status';

// Order
  static const String ORDER = '/api/v3/order';
}
