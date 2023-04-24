import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/pop_up_notification.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/data_classes/fcm_send.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/hr_modules/employees_list/views/emp_profile_view.dart';
import 'package:hr_management_system/salary_module/model/salary_model.dart';
import 'package:hr_management_system/salary_module/views/salary_update_view.dart';

class SalaryViewModel extends GetxController {
  RxString hrID = "".obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    loadData();
    super.onInit();
  }

  loadData() async {
    hrID.value = (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
  }

  createSalary() async {
    isLoading.value = true;

    final empList = <AddEmployeeModel>[];

    final empd = await FirebaseFirestore.instance
        .collection(AppConstants.employesCollectionName)
        .where("HR_id", isEqualTo: hrID.value)
        .get();
    for (var element in empd.docs) {
      empList.add(AddEmployeeModel.fromJson(element.data()));
    }
    if (empList.isEmpty) {
      PopUpNotification().show(
          "No employee in your company yet. Add employees first.",
          "Infromation");
      return;
    }
    ////////////////////// master salary
// final d =DateTime(2023, 2, 15);
    final mid = DateTime.now().microsecondsSinceEpoch.toString();
    final masterSalaryData = MasterSalaryModel(
      createdAt: mid,
      hrId: hrID.value,
      id: mid,
    );

    await FirebaseFirestore.instance
        .collection(AppConstants.salaryMasterCollectionName)
        .doc(mid)
        .set(masterSalaryData.toJson());
////////////// Details salary

    for (var emp in empList) {
      final sdId = DateTime.now().microsecondsSinceEpoch.toString();
      final salaryDetailData = DetailsSalaryModel(
        empId: emp.id,
        empDesignation: emp.designation,
        empName: emp.name,
        id: sdId,
        createdAt: sdId,
        salary: emp.salary.toString(),
        isPaid: false,
        masterId: mid,
      );
      await FirebaseFirestore.instance
          .collection(AppConstants.salarydeatailCollectionName)
          .doc(sdId)
          .set(salaryDetailData.toJson());
    }
    isLoading.value = false;

    /// get.to to salsry updtae page
    Get.to(() => SalaryUpdateView(masterId: mid));
  }

  salaryPayStatus(String docId, bool val, String mId) async {
    await FirebaseFirestore.instance
        .collection(AppConstants.salarydeatailCollectionName)
        .doc(docId)
        .update({
      "is_paid": val,
    });
    String fr = val ? "paid" : "not paid";

    FCM().send(
        title: "Salary",
        message: "Your salary of this month status is $fr.",
        collectionName: AppConstants.employesCollectionName,
        docId: mId);
  }

  showEmpProfile({String? docId}) async {
    final userDt = await FirebaseFirestore.instance
        .collection(AppConstants.employesCollectionName)
        .doc(docId)
        .get();
    Get.to(EmpProfileView(
        empData:
            AddEmployeeModel.fromJson(userDt.data() as Map<String, dynamic>)));
  }
}
