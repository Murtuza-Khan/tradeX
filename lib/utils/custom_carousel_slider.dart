import '../resources/exports/index.dart';

class CustomCarouselSlider extends StatefulWidget {
  final String? apiUrl;
  final List<SliderModel>? banners;
  final bool isLoading;
  final bool refreshData;

  const CustomCarouselSlider({
    super.key,
    this.apiUrl,
    this.banners,
    this.isLoading = true,
    this.refreshData = false,
  });

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  static BaseApiServices baseApiService = NetworkApiServices();
  List<SliderModel> data = [];

  int selectedIndex = 0;
  bool isLoading = true;

  Future<void> getSliderData() async {
    isLoading = true;
    if (widget.apiUrl == null || widget.apiUrl!.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        data = SliderModel.listFromJson([]);
        isLoading = false;
      });
    } else {
      var apiResponse = await baseApiService.getApi(widget.apiUrl!);
      if (apiResponse is bool) return;
      setState(() {
        data = SliderModel.listFromJson(apiResponse);
        isLoading = false;
      });
    }
  }

  void updateIndicatorIndex(int index) => setState(() => selectedIndex = index);

  @override
  void didUpdateWidget(covariant CustomCarouselSlider oldWidget) {
    if (widget.banners != null && widget.banners!.isNotEmpty) {
      setState(() {
        data = widget.banners ?? [];
        isLoading = false;
      });
    }

    if (widget.refreshData) getSliderData();

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    isLoading = widget.isLoading;
    if (widget.banners != null && widget.banners!.isNotEmpty) {
      setState(() => data = widget.banners ?? []);
    } else {
      getSliderData();
    }
    log.e(SliderModel.listToJson(data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: 200,
            margin: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ).shimmerWidget
        : Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  onPageChanged: (val, _) => updateIndicatorIndex(val),
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  aspectRatio: 1,
                  enlargeCenterPage: true,
                  viewportFraction: 0.95,
                ),
                items: data
                    .map(
                      (val) => SizedBox(
                        width: double.maxFinite,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: ImageService.image(
                            "${dotenv.get('HTTPS_BASE_URL')}${dotenv.get('SLIDER_BASE_URL')}${val.image ?? ""}",
                            borderRadius: 0.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SpaceH16(),
              AnimatedSmoothIndicator(
                activeIndex: selectedIndex,
                count: data.length,
                axisDirection: Axis.horizontal,
                effect: ExpandingDotsEffect(
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 6.0,
                  dotHeight: 6.0,
                  dotColor: Colors.grey,
                  activeDotColor: AppColors.primary,
                ),
              ),
            ],
          );
  }
}
