import '../../resources/exports/index.dart';

class SwitchAccount extends GetView<SwitchAccountController> {
  const SwitchAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.SWITCH_ACCOUNT_WBSN),
      body: CustomFutureBuilder(
        future: HomeRepository.getCompanies(),
        data: (companies) => controller.companies = companies ?? [],
        hasDataBuilder: (_, __) => _buildAccounts(context),
      ),
    );
  }

  Column _buildAccounts(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          padding: EdgeInsets.all(16.0),
          itemCount: controller.companies.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, index) => _buildItem(
            context,
            index,
            controller.companies[index],
          ),
          separatorBuilder: (_, __) => SpaceH16(),
        ).expanded(),
        CustomButton.solid(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          backgroundColor: AppColors.primary,
          textColor: AppColors.white,
          text: Strings.SAVE,
          onTapAsync: () async => controller.onSave(),
          radius: Sizes.RADIUS_12,
          constraints: const BoxConstraints(minHeight: 55),
        ),
        SizedBox(height: Platform.isAndroid ? 16 : 40)
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index, CompaniesModel company) {
    return GestureDetector(
      onTap: () => controller.onSwitchCompany(index),
      child: GetBuilder<SwitchAccountController>(
        id: 'toggle_company_account',
        builder: (_) {
          return Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: (company.isSelected ?? false)
                  ? AppColors.primaryLight
                  : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: (company.isSelected ?? false)
                    ? AppColors.primary
                    : AppColors.white,
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
                CustomRichText(
                  company.name ?? "-",
                  style: context.titleLarge,
                  children: [
                    TextSpan(
                      text:
                          " ( ${GlobalHelper.formatedNumber(value: company.points ?? 0)} )",
                      style:
                          context.titleSmall.copyWith(color: AppColors.success),
                    ),
                  ],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).expanded(),
                if (company.isSelected ?? false) ...[
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
