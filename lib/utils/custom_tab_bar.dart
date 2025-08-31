import '../resources/exports/index.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tab;
  final List<Widget> children;
  final TabController tabCtrl;

  const CustomTabBar({
    super.key,
    required this.tab,
    required this.children,
    required this.tabCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.white,
          child: TabBar(
            labelStyle: context.titleMedium,
            labelPadding: const EdgeInsets.symmetric(vertical: 10),
            controller: tabCtrl,
            labelColor: AppColors.black,
            isScrollable: false,
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            dividerColor: AppColors.shadow,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4.0,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: AppColors.primary, width: 4.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            indicatorColor: AppColors.primary,
            tabs: tab.map((e) => e).toList(),
          ),
        ),
        TabBarView(
          controller: tabCtrl,
          children: List.generate(children.length, (index) => children[index]),
        ).paddingSymmetric(horizontal: 16.0).expanded(),
      ],
    );
  }
}
