part of 'constants.dart';

class Gradients {
  static LinearGradient offline = const LinearGradient(
    begin: Alignment(-3.0, -3.0),
    end: Alignment(1.5, 1.5),
    colors: [AppColors.primary, AppColors.secondary],
  );

  static LinearGradient ticket = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [AppColors.primary, AppColors.indigoLight],
  );
  static LinearGradient ticketShimmer = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [AppColors.indigoLight, AppColors.primary, AppColors.indigoLight],
  );
}
