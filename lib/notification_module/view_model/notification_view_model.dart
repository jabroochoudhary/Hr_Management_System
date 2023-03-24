import 'package:get/get.dart';

import '../../data_classes/local_data_saver.dart';

class NotificationViewModel extends GetxController {
  final userId = "".obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadUserData();
  }

  loadUserData() async {
    userId.value =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
    // print(userId.value);
  }
}
