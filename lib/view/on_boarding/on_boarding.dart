import '../../resources/exports/index.dart';

class OnBoarding extends GetView<OnBoardingController> {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        leading: Get.previousRoute.isEmpty ? const SizedBox() : null,
      ),
      body: PageView(
        controller: controller.pageCtrl,
        onPageChanged: (index) => controller.onNextTap(index),
        physics: const BouncingScrollPhysics(),
        children: const [
          Welcome(),
          Welcome(),
          Welcome(),
          Welcome(),
        ],
      ),
      bottomNavigationBar: const SafeArea(child: IntroBottomNavBar()),
    );
  }
}
