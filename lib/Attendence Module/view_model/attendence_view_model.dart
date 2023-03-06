import 'package:get/get.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';

class AttendenceViewModel extends GetxController {
  RxString hr_id = "".obs;

  loadUserID() async {
    hr_id.value =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
    // print(hr_id.toString());
  }
}
