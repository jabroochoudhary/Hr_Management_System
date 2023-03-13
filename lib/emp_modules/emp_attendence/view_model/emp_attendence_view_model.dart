import 'package:get/get.dart';

import '../../../data_classes/local_data_saver.dart';

class EMPAttendenceViewModel extends GetxController {
  RxBool isHistoryHas = false.obs;
  RxString hr_id = "".obs;
  RxBool isLoading = true.obs;

  Future<void> loadUserID() async {
    hr_id.value =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
    // print(hr_id.toString());
  }
}
