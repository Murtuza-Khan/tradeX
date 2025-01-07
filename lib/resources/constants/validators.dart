part of 'constants.dart';

class Validators {
  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  static final passLengthValidator = MultiValidator(
    [..._minMaxValidator(title: 'Password ', min: 8, max: 20)],
  );

  static final accountNoValidator = MultiValidator(
    [
      ..._minMaxValidator(title: 'Account No.', min: 8, max: 17),
    ],
  );

  static final bankNameValidator = MultiValidator(
    [
      ..._minMaxValidator(title: 'Bank Name', min: 3, max: 50),
    ],
  );

  static final seqNoValidator = MultiValidator(
    [
      ..._minMaxValidator(title: 'Seq # ', min: 3, max: 3),
    ],
  );

  static List<TextFieldValidator> _minMaxValidator({
    required String title,
    required int min,
    required int max,
  }) =>
      [
        _minValidator(title: title, min: min),
        _maxValidator(title: title, max: max),
      ];

  static TextFieldValidator _minValidator({
    required String title,
    required int min,
  }) =>
      MinLengthValidator(
        min,
        errorText: '$title must be at least $min characters long.',
      );

  static TextFieldValidator _maxValidator({
    required String title,
    required int max,
  }) =>
      MaxLengthValidator(
        max,
        errorText: '$title should not be greater than $max characters.',
      );

  static String? validatePriceField(
    int? minPrice,
    int? maxPrice,
    String price,
  ) {
    if (price.isEmpty || price.toInt() < (minPrice ?? 0.0)) {
      return 'Minimum limit is ${NumberFormat.currency(decimalDigits: 0, symbol: Strings.PKR).format(minPrice)}';
    } else if (price.isEmpty || price.toInt() > (maxPrice ?? 0.0)) {
      return 'Maximum limit is ${NumberFormat.currency(decimalDigits: 0, symbol: Strings.PKR).format(maxPrice)}';
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    if ((phone ?? "").isEmpty || (phone ?? "").length < 11) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? amountValidator(String? price) {
    if ((price ?? "").isEmpty || (price ?? "").toInt() < 1) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  static String? voucherValidator(String? code) {
    if ((code ?? '').isEmpty || (code ?? '').length < 12) {
      return 'Voucher No must be at least 12 characters long.';
    }
    if (!RegExp(r'^\d{8}[A-Z]{4}$').hasMatch(code ?? '')) {
      return Strings.THE_FIRST_CHARACTERS;
    }
    return null;
  }

  static String? emailValidator(String? code) {
    if ((code ?? '').isEmpty) return 'Email is required';
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(code ?? '')) {
      return Strings.ENTER_A_VALID;
    }
    return null;
  }

  static String? alphanumericValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    final containsLetter = RegExp(r'[a-zA-Z]');
    final containsNumber = RegExp(r'[0-9]');
    if (!containsLetter.hasMatch(value) || !containsNumber.hasMatch(value)) {
      return 'Password must contain both letters and numbers';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
}
