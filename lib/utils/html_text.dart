import '../../../resources/exports/index.dart';

class HtmlText extends StatelessWidget {
  final Future? apiFn;
  final String? data;

  const HtmlText({super.key, this.apiFn, this.data});

  @override
  Widget build(BuildContext context) {
    return apiFn != null
        ? CustomFutureBuilder(
            customLoader: CustomLoading.spinKitThreeBouncePrimary,
            future: apiFn!,
            hasDataBuilder: (context, snapshot) {
              return _buildData(snapshot.data ?? '');
            },
          )
        : _buildData(data ?? '');
  }

  SingleChildScrollView _buildData(String data) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Html(
            style: {
              "h1": Style(
                maxLines: 2,
                display: Display.inline,
                textOverflow: TextOverflow.ellipsis,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              "h2": Style(
                display: Display.inline,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                color: AppColors.black,
              ),
              "p": Style(
                display: Display.inline,
                color: AppColors.black,
                fontWeight: FontWeight.normal,
                fontSize: FontSize(12.0),
              ),
              "ul": Style(
                display: Display.inline,
                color: AppColors.black,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.left,
              ),
              "li": Style(
                display: Display.listItem,
                padding: HtmlPaddings.symmetric(horizontal: 8.0),
                color: AppColors.black,
                textAlign: TextAlign.left,
                fontWeight: FontWeight.normal,
              ),
            },
            data: data,
          ),
        ],
      ),
    );
  }
}
