import '../resources/exports/index.dart';

class CustomLoadingWidget extends StatelessWidget {
  final Widget loaded;
  final bool isLoading;
  final Widget? loading;
  const CustomLoadingWidget({
    super.key,
    this.loading,
    required this.loaded,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: loading ?? CustomLoading.spinKitThreeBouncePrimary,
          )
        : loaded;
  }
}
