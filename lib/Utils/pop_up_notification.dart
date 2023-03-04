import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpNotification {
  show(String msg, String title) {
    Get.snackbar(title, msg,
        backgroundColor: Colors.black38,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
  }
}
