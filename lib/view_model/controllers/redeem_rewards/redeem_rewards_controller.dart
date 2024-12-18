import '../../../resources/exports/index.dart';

class RedeemRewardsController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController pointsCtrl;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    pointsCtrl = TextEditingController();
    super.onInit();
  }
}