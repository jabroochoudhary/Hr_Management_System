import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/pop_up_notification.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/notification_module/model/notification_model.dart';

import '../../data_classes/local_data_saver.dart';

class NotificationViewModel extends GetxController {
  final userId = "".obs;
  RxBool isLoading = false.obs;
  final rejectionController = TextEditingController().obs;
  RxBool isHr = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadUserData();
  }

  loadUserData() async {
    userId.value =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
    isHr.value =
        (await AppLocalDataSaver.getBool(AppLocalDataSaver.isHRLoginKey))!;
    // print(userId.value);
  }

  markedAsRead(String id) async {
    await FirebaseFirestore.instance
        .collection(AppConstants.notificationCollectionName)
        .doc(id)
        .update({"isActive": false});
  }

  markedAsUnRead(String id) async {
    await FirebaseFirestore.instance
        .collection(AppConstants.notificationCollectionName)
        .doc(id)
        .update({"isActive": true});
  }

  rejectLoanRequest(NotificationModel data) async {
    final message = data.message;

    RegExp regex = RegExp(r'Request loan of Rs. (\d+) in (\d+) installments.');

    // Extract the amount and installment number from the message string
    RegExpMatch? match = regex.firstMatch(message!);
    String? amount = match?.group(1);
    String? installments = match?.group(2);

    if (rejectionController.value.text.isNotEmpty) {
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final name =
          await AppLocalDataSaver.getString(AppLocalDataSaver.userName);
      final notify = NotificationModel(
        id: id,
        receiverId: data.senderId,
        senderId: data.receiverId,
        senderName: name,
        title: "Loan Rejected",
        designation: "Hr",
        isActive: true,
        message:
            "Your request for loan of Rs. $amount is rejected. ${rejectionController.value.text}",
      );
      await FirebaseFirestore.instance
          .collection(AppConstants.notificationCollectionName)
          .doc(id)
          .set(notify.toJson());
      Get.back();
    } else {
      PopUpNotification()
          .show("Please enter proper reason of rejection.", "Alert");
    }
  }
}
