import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_management_system/Utils/colors.dart';

class ToastMessage {
  // static toast({String message = "Message"}) {
  //   return Get.snackbar(
  //     "Information",
  //     message,
  //     messageText: AppText.text(
  //       message,
  //       fontsize: 18,
  //       fontweight: FontWeight.w600,
  //       color: AppColors.background,
  //     ),
  //     animationDuration: Duration(milliseconds: 500),
  //     duration: Duration(milliseconds: 1600),
  //     backgroundColor: AppColors.text,
  //     borderRadius: 12,
  //     colorText: AppColors.background,
  //     padding: EdgeInsets.all(12),
  //   );
  // }

  defaultYesNoDialouge(
    String title, {
    GestureTapCallback? onCancelPressed,
    GestureTapCallback? onConfirmPressed,
    String yesText = "Delete",
    String noText = "Cancel",
  }) {
    return Get.defaultDialog(
      cancelTextColor: AppColors.primarycolor,
      confirmTextColor: Colors.red,
      backgroundColor: Colors.white,
      title: "Confirmation",
      titleStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primarycolor,
      ),
      middleTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.text,
      ),
      middleText: title,
      cancel: InkWell(
        onTap: () {
          onCancelPressed!();
        },
        child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primarycolor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              noText,
              style: TextStyle(
                color: AppColors.background,
              ),
            ),
          ),
        ),
      ),
      confirm: InkWell(
        onTap: () {
          onConfirmPressed!();
          // print("Confrim pressed");
        },
        child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              yesText,
              style: TextStyle(
                color: AppColors.background,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
