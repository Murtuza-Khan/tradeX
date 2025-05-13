import '../../resources/exports/index.dart';

class Notifications extends GetView<NotificationsController> {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Strings.NOTIFICATIONS,
        actions: GestureDetector(
          onTap: () => controller.onReadAll(),
          child: Text(
            "Read All",
            style: context.titleLarge.copyWith(color: AppColors.primary),
          ).paddingOnly(right: 16),
        ),
      ),
      body: CustomPagination<NotificationModel>(
        apiUrl: Urls.NOTIFICATIONS,
        backgroundColor: AppColors.backgroundColor,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: Platform.isAndroid ? 20 : 45,
        ),
        separator: SpaceH16(),
        initList: NotificationModel.listFromJson,
        shimmer: (_) => HomeCardShimmer().shadow(radius: 12.0),
        shouldRefreshList: (_) => true,
        child: (_, index, __, ___, item, ctrl) {
          controller.pagingCtrl = ctrl;
          return _buildNotificationCard(context, item).shadow(radius: 12.0);
        },
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, NotificationModel item) {
    return Container(
      padding: EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: _buildTitleAndSubTitle(
          context,
          title: item.title,
          subTitle: item.message,
          isSeen: item.isSeen ?? false,
        ),
      ),
    ).shadow(radius: 12.0);
  }

  Widget _buildTitleAndSubTitle(
    BuildContext context, {
    String? title,
    String? subTitle,
    bool isSeen = false,
  }) {
    return Row(
      children: [
        isSeen
            ? Icon(
                EneftyIcons.notification_bing_outline,
                color: AppColors.primary,
                size: 33,
              )
            : RippleAnimation(
                color: AppColors.primary,
                delay: Duration(milliseconds: 300),
                repeat: true,
                minRadius: 12,
                maxRadius: 12,
                ripplesCount: 3,
                duration: Duration(milliseconds: 2500),
                child: Icon(
                  EneftyIcons.notification_bold,
                  color: AppColors.primary,
                  size: 33,
                ),
              ),
        SpaceW8(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '-',
              style: context.titleSmall.copyWith(color: AppColors.primary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SpaceH6(),
            Text(
              subTitle ?? '-',
              style: context.titleSmall.copyWith(color: AppColors.black),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ).expanded(),
      ],
    );
  }
}
