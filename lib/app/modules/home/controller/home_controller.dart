import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var selectedFilters = <String>[].obs;

  List<String> filterList = [
    "Newest",
    "Oldest",
    "Price low > High",
    "Price high > Low",
    "Best Selling",
  ];

  @override
  void onInit() {
    // todo initial page data..
    super.onInit();
  }

  void selectFilter(String value) {
    if (isSelect(value).value) {
      selectedFilters.clear();
    } else {
      selectedFilters.clear();
      selectedFilters.add(value);
    }
  }

  RxBool isSelect(String value) {
    return selectedFilters.any((e) => e == value).obs;
  }

}
