import 'package:get/get.dart';
import 'package:morphosis_demo/views/homeModule/homePage.dart';
import 'package:morphosis_demo/views/taskModule/allTasksPage.dart';

class BaseController extends GetxController {
  var _currentIndex = 0.obs;
  var isLoading = true.obs;

  final allTabs = [
    HomePage(),
    AllTasksPage(),
    AllTasksPage(
      isCompletedTaskPage: true,
    ),
  ];
  get currentIndex => _currentIndex.value;

  set currentIndex(index) {
    _currentIndex.value = index;
  }
}
