import '../resources/exports/index.dart';

typedef OnCardTap = Function(int id);
typedef CustomChild<T> = Widget Function(
  BuildContext context,
  int index,
  bool isLastIndex,
  ScrollController scrlCtrl,
  T item,
  PagingController<int, T> pagingCtrl,
);

typedef LoadedData<T> = Function(T?);
typedef ComapreFn<T> = bool Function(T, T);
typedef SortFn<T> = int Function(T, T);

class CustomPagination<T> extends StatefulWidget {
  /// Setting this variable to [TRUE] will make a [GRID] of items
  ///
  /// by default this eriable is set to [FALSE].
  final bool isDataInGrid;

  /// [HEIGHT_OF_LIST] will define height of horizontal list view,
  ///
  /// this variable will only work if [SCROLL_DIRECTION] is set to [AXIS.HORIZONTAL].
  final double heightOfListViewItem;

  /// [WIDTH_OF_LIST_VIEW_ITEM] will define width of each card inside horizontal
  ///
  /// list view, this variable will only work if [SCROLL_DIRECTION] is set
  ///
  /// to [AXIS.HORIZONTAL].
  final double widthOfListViewItem;

  /// If [IS_LIST_ITEMS_DELETABLE] is set to [TRUE], a delete icon will appear
  ///
  /// on card tap to remove item from list
  final bool isListItemsDeletable;

  /// Use [ON_CARD_TAP] to get the product id which you can use to get the product
  ///
  /// details from api.
  final OnCardTap? onCardTap;

  /// Pass the [API_URL] to get the list of items or products.
  final String apiUrl;

  /// [IS_GET_API] defines that weather the api is [GET_API] or [POST_API]
  ///
  /// By default [IS_GET_API] is set to [TRUE]
  final bool isGetApi;

  /// [PARAMETERS] will be passed as [QUERY_PARAMETERS] by default it take [PAGE]
  ///
  /// field which defines the [PAGINATION] page index.
  final Map<String, dynamic>? parameters;

  /// To add padding to either list or grid use this parameter [PADDING]
  final EdgeInsetsGeometry? padding;

  /// Defines number of items that will load, by default the size is [10]
  final int? pageSize;

  /// Defines [PAGE_INDEX] that will load, by default the [PAGE_INDEX] is [NULL]
  final int? pageIndex;

  /// pass child to build list of items
  final CustomChild child;

  /// Use [INIT_LIST] to convert api respnse to respective [LIST_OF_MODEL]
  final List<T> Function(List) initList;

  /// Use [SCROLL_DIRECTION] to convert the list into [HORIZONTAL_VIEW] or [VERTICAL_VIEW]
  ///
  /// by default the list is in [VERTICAL_VIEW]
  final Axis scrollDirection;

  /// Pass the shimmer according to the [CHILD] you passed
  ///
  /// by default it will show [CUPERTINO] or [CIRCULAR] loading
  ///
  /// according to the [CURRENT_PLATFORM]
  final Widget Function(int)? shimmer;

  /// To create separatorBuilder for [LIST_VIEW]
  ///
  /// note :: This widget have not effect of [GRID_VIEW]
  final Widget? separator;

  /// To create specific no shimmers by default the [SHIMMERS_COUNT] is [5]
  final int shimmersCount;

  /// To add items from outside use [CUSTOM_ITEMS]
  ///
  /// Note: if [CUSTOM_ITEMS] != null then these items will
  ///
  /// be added into the list without calling the api again
  ///
  /// example [POST_COMMENT_IN_IGNITE_USER_APP]
  final List<T>? customItems;

  /// Use [SCROLL_TO_TOP] to move to the top of the list when you add
  ///
  /// [CUSTOM_ITEMS] into the list in [LIST_VIEW] OR [GRID_VIEW]
  ///
  ///  by default the value is [NULL]
  ///
  /// Note: to see the implemantation go to the [COMMENT_SCREEN]
  ///
  /// of [IGNITE_EMP_APP]
  final bool? scrollToTop;

  /// Use [DATA] to get loaded items of pagination
  final LoadedData? data;

  /// To check if the item already exist in the list
  ///
  /// Note: to see the implemantation of [COMAPRE_FN] goto
  ///
  /// [HOME_POST_SCREEN] in [IGNITE] app
  final ComapreFn? compareFn;

  /// use [should_Refresh_List] to reload items in the list
  ///
  /// the [INT] it returns the [REFRESH_COUNT] of current [PAGINATED_LIST_OR_GRID_VIEW]
  ///
  /// Note: by default [SHOULD_REFRES_LIST] is [NULL]
  final bool Function(int)? shouldRefreshList;

  /// use [SHOW_SCROLL_BAR] to toggle scroll bar visibility
  ///
  /// note: by default [SHOW_SCROLL_BAR] is [TRUE]
  final bool showScrollBar;

  /// To add [FIRST_CHILD] on top of [LIST_VIEW] by default
  /// the value of [CUSTOM_FIRST_CHILD] is [NULL] and the [BOOL]
  ///
  /// indicates that weather the widget is [REBUILDING] intentionally
  /// or by the [ITEM_BUILDER] itself, if the bool is true make sure that the
  ///
  /// widget do not rebuild specially if the widget contains future like [API_CALL]
  ///
  /// Note: As of now it only work with [LIST_VIEW]
  final Widget Function(bool)? customFirstChild;

  /// To show search bar on top of [PAGINATION_VIEW] by default the [SEARCH_BAR]
  ///
  /// is [HIDDEN]
  final bool showSearchBar;

  /// To add [CUSTOM_SORTING] to the [PAGINATION_LIST]
  final SortFn? listSorting;

  /// To apply [FILTERS] to the [PAGINATION_LIST] use the [FILTER_ENUMS] to
  ///
  /// get the Result
  final Filters filter;

  /// To show [DUMMY_DATA] in the [PAGINATION_LIST]
  ///
  /// note: pass the [JSON_DATA] otheiwise it will not work
  final List<Map<String, dynamic>>? dummyData;

  /// To add [BACKGROUND_COLOR] to [LIST OR GRID VIEW] by default the
  ///
  /// [BACKGROUND_COLOR] is [WHITE]
  final Color backgroundColor;

  /// Use [PAGINATED_LIST_KEY] if the list is inside a [Map<String, dynamic>]
  final String? paginatedListKey;
  const CustomPagination({
    super.key,
    this.isDataInGrid = false,
    this.heightOfListViewItem = Sizes.HEIGHT_250,
    this.widthOfListViewItem = Sizes.WIDTH_250,
    this.isListItemsDeletable = false,
    this.onCardTap,
    this.isGetApi = true,
    this.parameters,
    this.padding,
    this.pageSize,
    this.pageIndex,
    this.scrollDirection = Axis.vertical,
    this.shimmer,
    this.separator,
    this.shimmersCount = 5,
    this.customItems,
    this.scrollToTop,
    this.data,
    this.compareFn,
    this.shouldRefreshList,
    this.showScrollBar = true,
    this.customFirstChild,
    this.showSearchBar = false,
    this.listSorting,
    this.filter = Filters.all,
    this.dummyData,
    this.paginatedListKey,
    this.backgroundColor = AppColors.white,
    required this.child,
    required this.apiUrl,
    required this.initList,
  });
  @override
  State<CustomPagination> createState() => _CustomPaginationState();
}

class _CustomPaginationState<T> extends State<CustomPagination> {
  late final PagingController<int, T> _pagingController;
  late ScrollController _scrlController;
  late TextEditingController _searchCtrl;
  late RxInt refreshCount;
  late int itemCount;
  late Filters initialFilter;

  final Duration _stopTypingDuration = Duration(milliseconds: 1000);
  Timer? _typingTimer;

  List<T> items = [];
  List<T> uniqueItems = [];

  (bool, int) isFinalPage = (false, -1);
  RxBool isLoading = false.obs;
  RxBool isWidgetAutoRebuilding = false.obs;
  int randomBuildCount = 0;

  // The package now asks for the next key instead of using appendPage/appendLastPage.
  bool _hasNextPage = true;

  Future<List<T>> _fetchPage(int pageKey) async {
    try {
      isFinalPage = (false, -1);

      final List<T> newItems = await _getList(pageKey);
      if (!mounted) return <T>[];

      items.addAll(newItems);
      itemCount += newItems.length;
      widget.data?.call(items);

      final pageSize = widget.pageSize ?? Urls.PAGESIZE;
      final isLastPage = newItems.length < pageSize;

      // Kept from the previous implementation.
      if (isLastPage || newItems.length <= pageSize) {
        isFinalPage = (true, items.length - 1);
      }

      final reachedPageLimit =
          widget.pageIndex != null && (widget.pageIndex ?? 1) <= (pageKey + 1);
      _hasNextPage = !(isLastPage || reachedPageLimit);

      // PagingController appends the returned page automatically in v5.
      final uniquePageItems = _removeDuplicateItems(newItems);
      return _sortNewPageAndExistingPages(uniquePageItems);
    } catch (error) {
      MacLog.printR(error);
      rethrow;
    }
  }

  Future<List<T>> _getList(int pageIndex) async {
    try {
      BaseApiServices apiService = NetworkApiServices();
      List<T> itemsList = [];
      Map<String, dynamic> queryParameters = {};

      isLoading.value = true;

      if (widget.parameters != null) {
        queryParameters.addAll(widget.parameters!);
      }
      if (widget.showSearchBar && _searchCtrl.text.isNotEmpty) {
        queryParameters["search"] = _searchCtrl.text;
      }

      if ((widget.dummyData ?? []).isEmpty) {
        queryParameters["page"] = (widget.pageIndex ?? pageIndex).toString();
        queryParameters["limit"] =
            (widget.pageSize ?? Urls.PAGESIZE).toString();
        queryParameters["post_type_id"] = widget.filter.id.toString();
        queryParameters["accountId"] =
            AuthManager.instance.company.id.toString();

        final response = widget.isGetApi
            ? await apiService.getApi(
                widget.apiUrl,
                queryParameters: queryParameters,
              )
            : await apiService.postApi(widget.apiUrl, body: queryParameters);

        if (response is bool) return itemsList;

        if (mounted) {
          setState(
            () => itemsList = widget.initList(
              widget.paginatedListKey != null
                  ? response['received_points']
                  : response,
            ) as List<T>,
          );
        }

        isLoading.value = false;
        // await Future.delayed(Duration(hours: 1));
        return itemsList;
      } else {
        if (mounted) {
          await Future.delayed(Duration(seconds: 1));
          setState(
            () =>
                itemsList = widget.initList(widget.dummyData ?? []) as List<T>,
          );
        }

        isLoading.value = false;
        // await Future.delayed(Duration(hours: 1));
        return itemsList;
      }
    } catch (e) {
      isLoading.value = false;
      if (Platform.isAndroid) {
        log.e("This is CUSTOM_PAGINATION error :: $e");
      } else {
        MacLog.printR("This is CUSTOM_PAGINATION error :: $e");
      }
      rethrow;
    }
  }

  // Returns only items that are not already present in previously loaded pages.
  // The controller itself appends this returned page to PagingState.pages.
  List<T> _removeDuplicateItems(List<T> newItems) {
    try {
      final existingItems = _pagingController.value.items ?? <T>[];

      // Keep the uniqueItems cache in sync with items inserted externally.
      for (final existingItem in existingItems) {
        final existingIndex = uniqueItems.indexWhere(
          (item) => (item as dynamic).id == (existingItem as dynamic).id,
        );
        if (existingIndex == -1) uniqueItems.add(existingItem);
      }

      final List<T> pageItems = [];
      for (final item in newItems) {
        final existingIndex = uniqueItems.indexWhere(
          (element) => (element as dynamic).id == (item as dynamic).id,
        );
        if (existingIndex == -1) {
          uniqueItems.add(item);
          pageItems.add(item);
        }
      }

      return pageItems;
    } catch (e) {
      MacLog.printR(e);
      return newItems;
    }
  }

  // Rebuilds the flat item collection while retaining the page/key structure
  // required by infinite_scroll_pagination 5.x.
  void _setPagingItems(List<T> updatedItems) {
    // Previously itemList and uniqueItems referenced the same list. Keep that
    // relationship explicit now that PagingState stores nested page lists.
    uniqueItems
      ..clear()
      ..addAll(updatedItems);

    final currentState = _pagingController.value;
    final currentPages = currentState.pages ?? <List<T>>[];
    final currentKeys = List<int>.from(currentState.keys ?? <int>[]);

    if (currentPages.isEmpty) {
      final keys = currentKeys.isEmpty ? <int>[0] : currentKeys;
      _pagingController.value = currentState.copyWith(
        pages: <List<T>>[List<T>.from(updatedItems)],
        keys: keys,
      );
      return;
    }

    final currentItemCount = currentPages.fold<int>(
      0,
      (count, page) => count + page.length,
    );
    final extraItems = updatedItems.length > currentItemCount
        ? updatedItems.length - currentItemCount
        : 0;

    final List<List<T>> updatedPages = [];
    var offset = 0;

    for (var index = 0; index < currentPages.length; index++) {
      final pageLength =
          currentPages[index].length + (index == 0 ? extraItems : 0);
      final availableItems = updatedItems.length - offset;
      final takeCount =
          pageLength < availableItems ? pageLength : availableItems;

      updatedPages.add(
        updatedItems.skip(offset).take(takeCount).toList(),
      );
      offset += takeCount;
    }

    if (offset < updatedItems.length) {
      if (updatedPages.isEmpty) {
        updatedPages.add(updatedItems.sublist(offset));
      } else {
        updatedPages[0] = [
          ...updatedPages[0],
          ...updatedItems.skip(offset),
        ];
      }
    }

    // Normally the key/page counts already match. This also keeps manually
    // inserted items valid when the state has not fetched an API page yet.
    while (currentKeys.length < updatedPages.length) {
      currentKeys.add(currentKeys.isEmpty ? 0 : currentKeys.last + 1);
    }
    if (currentKeys.length > updatedPages.length) {
      currentKeys.removeRange(updatedPages.length, currentKeys.length);
    }

    _pagingController.value = currentState.copyWith(
      pages: updatedPages,
      keys: currentKeys,
    );
  }

  // Keeps the previous global sorting behavior while preserving the page
  // boundaries required by the v5 PagingState.
  List<T> _sortNewPageAndExistingPages(List<T> newPageItems) {
    final sorting = widget.listSorting;
    if (sorting == null || newPageItems.isEmpty) return newPageItems;

    final currentState = _pagingController.value;
    final currentPages = currentState.pages ?? <List<T>>[];
    final sortedItems = List<T>.from(currentState.items ?? <T>[])
      ..addAll(newPageItems);

    sortedItems.sort((a, b) => sorting.call(a, b));

    var offset = 0;
    final sortedExistingPages = <List<T>>[];
    for (final page in currentPages) {
      final end = offset + page.length;
      sortedExistingPages.add(sortedItems.sublist(offset, end));
      offset = end;
    }

    // Keep the cache in the same order as the old controller.itemList.
    uniqueItems
      ..clear()
      ..addAll(sortedItems);

    // The controller will append the returned final page after this callback.
    // Updating the existing pages synchronously is supported by v5 PagingController.
    _pagingController.value = currentState.copyWith(
      pages: sortedExistingPages,
    );

    return sortedItems.sublist(offset);
  }

  void _scrollToTop() {
    if (_scrlController.hasClients && (widget.scrollToTop ?? false)) {
      setState(() {
        _scrlController.animateTo(
          _scrlController.position.minScrollExtent,
          duration: Durations.medium2,
          curve: Curves.linear,
        );
      });
    }
  }

  Future<void> _onSearch() async {
    if (_typingTimer != null) _typingTimer!.cancel();
    _typingTimer = Timer(_stopTypingDuration, () {
      uniqueItems.clear();
      items.clear();
      _hasNextPage = true;
      _pagingController.refresh();
    });
  }

  Widget refreshIndicatorWidget({required Widget child}) {
    randomBuildCount = 0;
    if (isLoading.value) {
      isWidgetAutoRebuilding.value = false;
      return child;
    }
    bool refresh = false;
    if (widget.shouldRefreshList != null) {
      refresh = widget.shouldRefreshList?.call(refreshCount.value) ?? false;
      if (isFinalPage.$1) refreshCount.value++;
      isWidgetAutoRebuilding.value = false;
    }
    if (refresh) {
      return RefreshIndicator(
        color: AppColors.black,
        onRefresh: () async {
          items.clear();
          uniqueItems.clear();
          _hasNextPage = true;
          _pagingController.refresh();
        },
        child: child,
      );
    } else {
      return child;
    }
  }

  @override
  void initState() {
    super.initState();
    itemCount = 0;
    refreshCount = 0.obs;
    initialFilter = widget.filter;
    _searchCtrl = TextEditingController();
    _scrlController = ScrollController();

    _pagingController = PagingController<int, T>(
      getNextPageKey: (state) {
        if (!_hasNextPage) return null;
        final keys = state.keys;
        if (keys == null || keys.isEmpty) return 1;
        return keys.last + 1;
      },
      fetchPage: _fetchPage,
    );
  }

  @override
  void didUpdateWidget(covariant CustomPagination oldWidget) {
    final currentItems = List<T>.from(_pagingController.value.items ?? <T>[]);

    if (widget.compareFn != null) {
      if ((widget.customItems ?? []).isNotEmpty && currentItems.isNotEmpty) {
        for (int i = 0; i < (widget.customItems ?? []).length; i++) {
          for (int j = 0; j < currentItems.length; j++) {
            final bool shouldUpdate = widget.compareFn
                    ?.call(currentItems[j], widget.customItems![i]) ??
                false;

            if (shouldUpdate) {
              currentItems[j] = widget.customItems![i];
              _setPagingItems(currentItems);
              return;
            } else if (j == currentItems.length - 1) {
              if (currentItems.length >= (widget.pageSize ?? Urls.PAGESIZE)) {
                currentItems.removeAt(currentItems.length - 1);
              }
              currentItems.insert(0, widget.customItems![i]);
              _setPagingItems(currentItems);
              return;
            }
          }
        }
      }
    }

    if (widget.compareFn == null || currentItems.isEmpty) {
      currentItems.insertAll(0, (widget.customItems ?? []).cast<T>());
      _setPagingItems(currentItems);
    }

    if (widget.filter != initialFilter) {
      initialFilter = widget.filter;
      items.clear();
      uniqueItems.clear();
      _hasNextPage = true;
      _pagingController.refresh();
    }

    _scrollToTop();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchCtrl.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagingListener<int, T>(
      controller: _pagingController,
      builder: (context, state, fetchNextPage) {
        return Container(
          color: widget.backgroundColor,
          child: Column(
            children: [
              if (widget.showSearchBar && itemCount != 0) ...[
                SpaceH12(),
                CustomTextFormField(
                  controller: _searchCtrl,
                  textCapitalization: TextCapitalization.none,
                  height: Sizes.HEIGHT_20,
                  labelText: Strings.SEARCH,
                  labelColor: AppColors.black,
                  prefixIcon: EneftyIcons.search_normal_2_outline,
                  prefixIconColor: AppColors.black,
                  textColor: AppColors.black,
                  cursorColor: AppColors.black,
                  enableBorderColor: AppColors.black,
                  focusBorderColor: AppColors.primary,
                  suffixIconColor: AppColors.black,
                  suffixIcon: _searchCtrl.text.isEmpty
                      ? null
                      : EneftyIcons.close_circle_outline,
                  onSuffixTap: () => _searchCtrl.clear(),
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => _onSearch(),
                  keyboardType: TextInputType.name,
                ).paddingSymmetric(horizontal: 16.0),
              ],
              if (state.status == PagingStatus.noItemsFound) ...[
                if (widget.customFirstChild != null) ...[
                  widget.customFirstChild
                          ?.call(isWidgetAutoRebuilding.value)
                          .paddingSymmetric(horizontal: 16.0) ??
                      SizedBox(),
                  SizedBox(height: 80),
                  NoContent(
                    title: Strings.NO_RECORD_FOUND,
                    subtitle: "No information is currently available",
                    showBackground: false,
                  ).expanded(),
                ],
              ],
              widget.isDataInGrid
                  ? _buildGridView(state, fetchNextPage).expanded()
                  : _buildListView(state, fetchNextPage).expanded(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListView(
    PagingState<int, T> state,
    VoidCallback fetchNextPage,
  ) {
    final itemLength = state.items?.length ?? 0;

    return refreshIndicatorWidget(
      child: SizedBox(
        height: widget.scrollDirection == Axis.vertical
            ? null
            : widget.heightOfListViewItem,
        child: Align(
          alignment: itemLength == 0 ? Alignment.center : Alignment.topCenter,
          child: RawScrollbar(
            controller: _scrlController,
            thumbVisibility: widget.showScrollBar,
            thickness: widget.showScrollBar ? 5 : 0,
            thumbColor:
                widget.showScrollBar ? AppColors.primary : Colors.transparent,
            crossAxisMargin: widget.showScrollBar ? 4 : 0,
            radius: widget.showScrollBar ? Radius.circular(8.0) : null,
            child: PagedListView<int, T>.separated(
              state: state,
              fetchNextPage: fetchNextPage,
              padding: widget.padding,
              shrinkWrap: true,
              scrollDirection: widget.scrollDirection,
              physics: ClampingScrollPhysics(),
              scrollController: _scrlController,
              builderDelegate: PagedChildBuilderDelegate<T>(
                itemBuilder: (context, item, index) {
                  isWidgetAutoRebuilding.value = randomBuildCount != 0;
                  randomBuildCount++;
                  return Column(
                    children: [
                      if (widget.customFirstChild != null && index == 0) ...[
                        widget.customFirstChild
                                ?.call(isWidgetAutoRebuilding.value) ??
                            SizedBox(),
                      ],
                      widget.child(
                        context,
                        index,
                        index == itemLength - 1,
                        _scrlController,
                        item,
                        _pagingController,
                      ),
                    ],
                  );
                },
                firstPageProgressIndicatorBuilder: (context) =>
                    widget.shimmer != null
                        ? _buildFirstPageShimmerList()
                        : GlobalHelper.loadingWidget(),
                newPageProgressIndicatorBuilder: (_) =>
                    widget.shimmer?.call(-1) ?? GlobalHelper.loadingWidget(),
                firstPageErrorIndicatorBuilder: (_) => Align(
                  alignment: Alignment.center,
                  child: NoContent(
                    title: Strings.NO_RECORD_FOUND,
                    subtitle: "Something went wrong",
                    padding: 32,
                    showBackground: false,
                  ),
                ),
                noItemsFoundIndicatorBuilder: (_) =>
                    widget.customFirstChild != null
                        ? SizedBox()
                        : Align(
                            alignment: Alignment.center,
                            child: NoContent(
                              title: Strings.NO_RECORD_FOUND,
                              subtitle: "No information is currently available",
                              showBackground: false,
                            ),
                          ),
                newPageErrorIndicatorBuilder: (_) => Align(
                  alignment: Alignment.center,
                  child: GlobalHelper.loadingWidget(),
                ),
              ),
              separatorBuilder: (_, __) => widget.separator ?? const SpaceH24(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(
    PagingState<int, T> state,
    VoidCallback fetchNextPage,
  ) {
    final itemLength = state.items?.length ?? 0;

    return refreshIndicatorWidget(
      child: Center(
        child: RawScrollbar(
          controller: _scrlController,
          thumbVisibility: widget.showScrollBar,
          thickness: widget.showScrollBar ? 5 : 0,
          thumbColor:
              widget.showScrollBar ? AppColors.primary : Colors.transparent,
          crossAxisMargin: widget.showScrollBar ? 4 : 0,
          radius: widget.showScrollBar ? Radius.circular(8.0) : null,
          child: PagedGridView<int, T>(
            addAutomaticKeepAlives: true,
            state: state,
            fetchNextPage: fetchNextPage,
            padding: const EdgeInsets.all(Sizes.PADDING_12),
            addRepaintBoundaries: true,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollController: _scrlController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Sizes.WIDTH_18,
              mainAxisSpacing: Sizes.HEIGHT_20,
              childAspectRatio: 3 / 3.1,
            ),
            builderDelegate: PagedChildBuilderDelegate<T>(
              firstPageProgressIndicatorBuilder: (context) =>
                  widget.shimmer != null
                      ? _buildFirstPageShimmerList()
                      : GlobalHelper.loadingWidget(),
              newPageProgressIndicatorBuilder: (context) =>
                  widget.shimmer?.call(0) ?? GlobalHelper.loadingWidget(),
              firstPageErrorIndicatorBuilder: (context) => const Align(
                alignment: Alignment.center,
                child: NoContent(
                  title: Strings.NO_RECORD_FOUND,
                  subtitle: "Something went wrong",
                  padding: 32,
                  showBackground: false,
                ),
              ),
              noItemsFoundIndicatorBuilder: (_) => Align(
                alignment: Alignment.center,
                child: NoContent(
                  title: Strings.NO_RECORD_FOUND,
                  subtitle: "No Items found",
                  padding: 32,
                  showBackground: false,
                ),
              ),
              newPageErrorIndicatorBuilder: (_) => Align(
                alignment: Alignment.center,
                child: GlobalHelper.loadingWidget(),
              ),
              itemBuilder: (context, item, index) => widget.child(
                context,
                index,
                index == itemLength - 1,
                _scrlController,
                item,
                _pagingController,
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildFirstPageShimmerList() {
    return SizedBox(
      height: widget.scrollDirection == Axis.vertical
          ? null
          : widget.heightOfListViewItem,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: widget.shimmersCount,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: widget.scrollDirection,
        itemBuilder: (_, index) => widget.shimmer?.call(index),
        separatorBuilder: (_, __) => SpaceH16(),
      ),
    );
  }
}
