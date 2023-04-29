import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Loan%20Module/model/loan_details_model.dart';
import 'package:hr_management_system/Loan%20Module/model/loan_master_model.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';

import '../../../Utils/pop_up_notification.dart';
import '../../../data_classes/constants.dart';
import '../../add_empoyee/model/add_empoyee_model.dart';

class EmployeesListViewModel extends GetxController {
  RxString hrId = "".obs;
  RxBool isLoading = false.obs;
  final nameController = TextEditingController().obs;
  final fnameController = TextEditingController().obs;
  final ageController = TextEditingController().obs;
  final cnicController = TextEditingController().obs;
  final contactController = TextEditingController().obs;

  final educationController = TextEditingController().obs;
  final expertiesController = TextEditingController().obs;
  final designationController = TextEditingController().obs;
  final spouseController = TextEditingController().obs;
  final childrensController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final salaryController = TextEditingController().obs;
  final joiningDateController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadUserData();
  }

  loadUserData() async {
    hrId.value = (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
  }

  updateEmployeeSideAccount(AddEmployeeModel empData) async {
    if (nameController.value.text.isNotEmpty &&
        fnameController.value.text.isNotEmpty &&
        ageController.value.text.isNotEmpty &&
        contactController.value.text.isNotEmpty &&
        cnicController.value.text.isNotEmpty &&
        educationController.value.text.isNotEmpty &&
        expertiesController.value.text.isNotEmpty &&
        designationController.value.text.isNotEmpty &&
        spouseController.value.text.isNotEmpty &&
        childrensController.value.text.isNotEmpty &&
        addressController.value.text.isNotEmpty &&
        salaryController.value.text.isNotEmpty &&
        joiningDateController.value.text.isNotEmpty &&
        emailController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty) {
      isLoading.value = true;
      empData.contact = contactController.value.text;
      empData.education = educationController.value.text;
      empData.expertise = expertiesController.value.text;
      empData.salary = int.parse(salaryController.value.text);
      empData.designation = designationController.value.text;

      await FirebaseFirestore.instance
          .collection(AppConstants.employesCollectionName)
          .doc(empData.id)
          .update(empData.toJson());
      Get.back();

      PopUpNotification().show("Employee account is updated.", "Sucess");
    } else {
      isLoading.value = false;
      PopUpNotification()
          .show("Please fill all attributes with proper data", "Information");
    }
  }

  deleteEmployee(String empId, String name) async {
    var masterLoanList = <LoanMasterModel>[];
    var detalLoanList = <LoanDetailsModel>[];
    await FirebaseFirestore.instance
        .collection(AppConstants.loanMasterCollectionName)
        .where("emp_id", isEqualTo: empId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        masterLoanList.add(LoanMasterModel.fromJson(element.data()));
      }
    });
    for (var element in masterLoanList) {
      await FirebaseFirestore.instance
          .collection(AppConstants.loanDetailsCollectionName)
          .where("master_loan_id", isEqualTo: element.id)
          .get()
          .then((value) {
        for (var e in value.docs) {
          detalLoanList.add(LoanDetailsModel.fromJson(e.data()));
        }
      });
    }
    int remainingLoans = 0;
    for (var c in detalLoanList) {
      if (!c.isPaid!) {
        remainingLoans += 1;
      }
    }
    if (remainingLoans > 0) {
      PopUpNotification().show(
          "$remainingLoans installments remain for $name. You cannot delete this employee.",
          "Information");
    } else {
      await FirebaseFirestore.instance
          .collection(AppConstants.employesCollectionName)
          .doc(empId)
          .delete();

      for (var element in masterLoanList) {
        await FirebaseFirestore.instance
            .collection(AppConstants.loanMasterCollectionName)
            .doc(element.id)
            .delete();
      }

      for (var element in detalLoanList) {
        await FirebaseFirestore.instance
            .collection(AppConstants.loanDetailsCollectionName)
            .doc(element.id)
            .delete();
      }
      final attendenceRefrence = FirebaseFirestore.instance
          .collection(AppConstants.hrAttandenceCollection)
          .doc(hrId.value)
          .collection(AppConstants.datesCollectionInHrAttandence);
      await attendenceRefrence.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference
              .collection(
                  AppConstants.attendenceInDatesCollectionInHrAttandence)
              .where("emp_id", isEqualTo: empId)
              .get()
              .then((att) {
            for (var at in att.docs) {
              at.reference.delete();
            }
          });
        }
      });

      final salaryReff = FirebaseFirestore.instance
          .collection(AppConstants.salarydeatailCollectionName);
      await salaryReff.where("emp_id", isEqualTo: empId).get().then((snaps) {
        for (var element in snaps.docs) {
          element.reference.delete();
        }
      });
    }
  }
}
