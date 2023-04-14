import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../add_empoyee/model/add_empoyee_model.dart';
import '../../../data_classes/constants.dart';
import '../../../data_classes/local_data_saver.dart';

class LeaveRecordViewModel extends GetxController {
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   loadUserID();
  //   loadLeaves();
  // }

  RxBool isHistoryHas = false.obs;
  RxString hr_id = "".obs;
  RxBool isLoading = true.obs;
  RxString loadingString = "Loading Employees Data".obs;

  Future<void> loadUserID() async {
    hr_id.value =
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
        .where("HR_id", isEqualTo: hr_id.value)
        .get()
        .then((value) {
      for (var element in value.docs) {
        final dt = AddEmployeeModel.fromJson(element.data());
        listEmployees.add(dt);
      }
    });
    final listDates = <String>[];
    loadingString.value = "Loading Attendance Dates";
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
    int counter = 0;
    loadingString.value = "Loading Employees Attendance";
    final half = (listEmployees.length / 2);
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
      counter++;
      if (half < counter) {
        loadingString.value = "Summerizing Attendance";
      }
    }
    loadingString.value = "Summerizing Attendance";
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
