part of 'constants.dart';

class InputFormat {
  static final denySpace = <TextInputFormatter>[
    FilteringTextInputFormatter.deny(RegExp(r'\s')),
  ];

  static final onlyNumber = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
  ];

  static final accountNumber = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(17),
  ];
  
  static final cnicCount = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(13),
  ];

  static final phoneNumber = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(11),
  ];

  static final bankName = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp("[\\sa-zA-Z]")),
    LengthLimitingTextInputFormatter(50),
    FirstLetterUpperCaseTextFormatter(),
  ];

  static final voucherNo = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
    UpperCaseTextFormatter(),
    LengthLimitingTextInputFormatter(12),
  ];

  static final seqNo = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
    LengthLimitingTextInputFormatter(3),
  ];

  static final amount = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
    LengthLimitingTextInputFormatter(5),
  ];
}

class FirstLetterUpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }

  String capitalize(String value) {
    if (value.trim().isEmpty) return "";
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }

  String capitalize(String value) {
    if (value.trim().isEmpty) return "";
    return value.toUpperCase();
  }
}

class CnicInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 5 || i == 12) {
        formatted += '-';
      }
      formatted += digitsOnly[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
