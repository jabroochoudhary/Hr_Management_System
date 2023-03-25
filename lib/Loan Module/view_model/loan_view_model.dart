import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/pop_up_notification.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/notification_module/model/notification_model.dart';

class LoanViewModel extends GetxController {
  final selectedAmount = 0.obs;
  final isLoading = false.obs;
  final descController = TextEditingController().obs;
  final installmentsController = TextEditingController().obs;

  requestLoan() async {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final hrId =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.empHRidKey))!;
    if (selectedAmount.value > 0 &&
        descController.value.text.isNotEmpty &&
        installmentsController.value.text.isNotEmpty) {
      final userData = await loadUserCloudData();
      if (userData.id!.isNotEmpty) {
        final data = NotificationModel(
          designation: userData.designation,
          senderId: userData.id,
          id: id,
          isActive: true,
          message:
              "Request loan of Rs. $selectedAmount in ${installmentsController.value.text} installments. ${descController.value.text}",
          receiverId: hrId,
          senderName: userData.name,
          title: "Request Loan",
        );
        await FirebaseFirestore.instance
            .collection(AppConstants.notificationCollectionName)
            .doc(id)
            .set(data.toJson());
        Get.back();
        PopUpNotification()
            .show("Request is sent. You will be notified.", "Sucess");
        selectedAmount.value = 0;
      } else {
        PopUpNotification().show(
            "Something went wrong. Login again to resolve issues.", "Alert");
      }
    } else {
      PopUpNotification().show("Please enter proper data in fields.", "Alert");
    }
  }

  Future<AddEmployeeModel> loadUserCloudData() async {
    try {
      final userId =
          (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
      // print(userId);
      final dt = await FirebaseFirestore.instance
          .collection(AppConstants.employesCollectionName)
          .doc(userId)
          .get();
      // print(dt.data());
      return AddEmployeeModel.fromJson(dt.data() as Map<String, dynamic>);
    } catch (e) {
      // print(e);
      return AddEmployeeModel();
    }
  }
}
