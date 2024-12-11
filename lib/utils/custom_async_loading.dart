import '../resources/exports/index.dart';

class CustomAsyncLoading<T> extends StatefulWidget {
  final Widget? loading;
  final Widget? empty;
  final bool Function(T)? isEmpty;
  final Widget Function(T) loaded;
  final Future<T> Function() asyncFunction;

  const CustomAsyncLoading({
    super.key,
    this.loading,
    this.empty,
    this.isEmpty,
    required this.loaded,
    required this.asyncFunction,
  });

  @override
  State<CustomAsyncLoading<T>> createState() => _CustomLoadingWidgetState<T>();
}

class _CustomLoadingWidgetState<T> extends State<CustomAsyncLoading<T>> {
  bool _isLoading = false;
  bool _isEmpty = false;
  T? _loadedData;

  Future<void> _loadData() async {
    try {
      setState(() => _isLoading = true);
      _loadedData = await widget.asyncFunction.call();
      if (_loadedData == null ||
          (_loadedData is List && (_loadedData as List).isEmpty)) {
        setState(() => _isEmpty = true);
      }
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _isEmpty = true;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: widget.loading ?? CustomLoading.spinKitThreeBouncePrimary,
          )
        : _loadedData == null ||
                (widget.isEmpty?.call(_loadedData as T) ?? _isEmpty)
            ? widget.empty ?? _buildDefaultEmptyWidget()
            : widget.loaded(_loadedData as T);
  }

  Widget _buildDefaultEmptyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.NO_DATA_FOUND, style: context.headlineSmall),
        const SpaceH10(),
        Text(
          Strings.DATA_NOT_AVAILABLE,
          style: context.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    ).paddingSymmetric(horizontal: 16.0);
  }
}
