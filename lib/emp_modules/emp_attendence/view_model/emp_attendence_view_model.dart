import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data_classes/constants.dart';
import '../../../data_classes/local_data_saver.dart';
import '../../../hr_modules/add_empoyee/model/add_empoyee_model.dart';

class EMPAttendenceViewModel extends GetxController {
  RxBool isHistoryHas = false.obs;
  RxString hr_id = "".obs;
  RxBool isLoading = true.obs;
  RxString emp_id = "".obs;

  RxInt present = 0.obs;
  RxInt absent = 0.obs;
  RxInt leave = 0.obs;
  RxList dt = <LeavesModel>[].obs;

  Future<void> loadUserID() async {
    hr_id.value =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.empHRidKey))!;
    emp_id.value =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;

    // print(hr_id.toString());
  }

  final listLeavesModel = <LeavesModel>[];
  final listLeavesCount = <LeavesCountModel>[];

  Future<void> loadLeaves() async {
    if (hr_id.value == "") {
      await loadUserID();
    }
    final listEmployees = <AddEmployeeModel>[];

    await FirebaseFirestore.instance
        .collection(AppConstants.employesCollectionName)
        .doc(emp_id.value)
        .get()
        .then((value) {
      final dt =
          AddEmployeeModel.fromJson(value.data() as Map<String, dynamic>);
      listEmployees.add(dt);
    });
    final listDates = <String>[];
    await FirebaseFirestore.instance
        .collection(AppConstants.hrAttandenceCollection)
        .doc(hr_id.value)
        .collection(AppConstants.datesCollectionInHrAttandence)
        .orderBy("created_at", descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        listDates.add(element['id']);
      }
    });
    listLeavesModel.clear();
    listLeavesCount.clear();

    for (var emp in listEmployees) {
      for (var date in listDates) {
        await FirebaseFirestore.instance
            .collection(AppConstants.hrAttandenceCollection)
            .doc(hr_id.value)
            .collection(AppConstants.datesCollectionInHrAttandence)
            .doc(date)
            .collection(AppConstants.attendenceInDatesCollectionInHrAttandence)
            .doc(emp.id)
            .get()
            .then((value) {
          int st = 5;
          try {
            st = value['status'];
            // print(st.runtimeType);
          } catch (e) {}
          listLeavesModel.add(LeavesModel(
            id: emp.id,
            name: emp.name,
            date: date,
            designation: emp.designation,
            status: st,
          ));
          // print(emp.name.toString() + st.toString());
        });
      }
    }

    for (var emp in listEmployees) {
      int countLeave = 0;
      for (var leve in listLeavesModel) {
        if (emp.id == leve.id) {
          if (leve.status == 2) {
            countLeave += 1;
          }
        }
      }
      listLeavesCount.add(LeavesCountModel(
        designation: emp.designation,
        id: emp.id,
        name: emp.name,
        status: countLeave,
      ));
    }
////////////////////////////

    // print(_controller.hr_id.value.toString() + "  >HR_ID");
    // print(_controller.emp_id.value.toString() + "  >EMP_ID");

    for (var element in listLeavesModel) {
      if (element.id.toString() == emp_id.value) {
        dt.add(element);
        element.status == 0
            ? absent.value += 1
            : element.status == 1
                ? present.value += 1
                : element.status == 2
                    ? leave.value += 1
                    : 8;
      }
    }

    isLoading.value = false;
  }
}

class LeavesCountModel {
  int? status;
  String? id;
  String? name;
  String? designation;
  LeavesCountModel({
    this.designation,
    this.id,
    this.name,
    this.status,
  });
}

class LeavesModel {
  String? date;
  int? status;
  String? id;
  String? name;
  String? designation;
  LeavesModel({
    this.date,
    this.designation,
    this.id,
    this.name,
    this.status,
  });
}
