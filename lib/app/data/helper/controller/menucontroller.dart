import 'package:get/get.dart';

class SelectMenuController extends GetxController {
  RxInt selectedMenuIndex = 0.obs;

  void setSelectedMenuIndex(int index) {
    selectedMenuIndex.value = index;
  }
}
