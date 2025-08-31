import '../../../resources/exports/index.dart';

class NumbersList extends GetView<ForgotPasswordController> {
  const NumbersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "${Strings.PHONE_NUMBER}'s"),
      body: Column(
        children: [
          ListView.separated(
            padding: EdgeInsets.all(16.0),
            itemCount: controller.numbers.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (_, index) => _buildItem(
              context,
              index,
              controller.numbers[index],
            ),
            separatorBuilder: (_, __) => SpaceH16(),
          ).expanded(),
          CustomButton.solid(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            text: Strings.SEND_OTP,
            onTapAsync: () async => controller.onSendOtp(),
            radius: Sizes.RADIUS_12,
            constraints: const BoxConstraints(minHeight: 55),
          ),
          SizedBox(height: Platform.isAndroid ? 16 : 40)
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    UserMobileNumbers number,
  ) {
    return GestureDetector(
      onTap: () => controller.onSwitchPhoneNumber(index),
      child: GetBuilder<ForgotPasswordController>(
        id: 'toggle_user_phone',
        builder: (_) {
          return Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: number.isSelected ? AppColors.primaryLight : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: number.isSelected ? AppColors.primary : AppColors.white,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  EneftyIcons.buildings_2_outline,
                  color: AppColors.primary,
                  size: 30,
                ),
                SpaceW12(),
                Text(
                  number.mobile ?? "-",
                  style: context.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).expanded(),
                if (number.isSelected) ...[
                  Icon(
                    EneftyIcons.tick_circle_outline,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ],
              ],
            ),
          ).shadow(radius: 12.0);
        },
      ),
    );
  }
}
