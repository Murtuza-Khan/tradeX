import '../../../resources/exports/index.dart';

class HomeController extends GetxController {
  ReceivedPointsModel receivedPoints = ReceivedPointsModel();

  bool get isReceivedPointsEmpty =>
      (receivedPoints.receivedPoints ?? []).isEmpty;
}
