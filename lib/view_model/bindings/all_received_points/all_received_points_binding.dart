import '../../../resources/exports/index.dart';

class AllReceivedPointsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> AllReceivedPointsController());
  }
}