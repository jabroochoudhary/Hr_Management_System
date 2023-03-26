import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:hr_management_system/Utils/custom_textbox.dart';
import 'package:hr_management_system/Utils/loading_indicator.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/notification_module/model/notification_model.dart';
import 'package:hr_management_system/notification_module/view_model/notification_view_model.dart';

import '../../Utils/colors.dart';
import '../../Utils/custom_appbar.dart';

class NotificationDetailsView extends StatelessWidget {
  NotificationModel obj;
  NotificationDetailsView(this.obj, {super.key});
  final _controller = Get.find<NotificationViewModel>();

  @override
  Widget build(BuildContext context) {
    final datet =
        DateTime.fromMicrosecondsSinceEpoch(int.parse(obj.id!.toString()));
    final date = "${datet.day}-${datet.month}-${datet.year}";
    final message = obj.message;

    RegExp regex = RegExp(r'Request loan of Rs. (\d+) in (\d+) installments.');

    // Extract the amount and installment number from the message string
    RegExpMatch? match = regex.firstMatch(message!);
    String? amount = match?.group(1);
    String? installments = match?.group(2);

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_sharp),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          // bottomOpacity: 0,
          elevation: 0,
          flexibleSpace: const CustomAppbar(
            text: "Notification Detail",
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: obj.isActive!
                    ? const Color.fromARGB(255, 222, 90, 255)
                    : AppColors.primarycolor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        obj.title!,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                obj.isActive! ? Colors.yellow : Colors.black),
                      ),
                      Icon(
                        obj.isActive!
                            ? Icons.notifications_active
                            : Icons.notifications,
                        color: obj.isActive! ? Colors.yellow : Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        obj.senderName!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        obj.designation!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Message: ${obj.message!}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 4, 86, 14),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Received at: $date",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _controller.isHr.value
                ? Column(
                    children: [
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      _controller.isLoading.value
                          ? LoadingIndicator()
                              .loadingWithLabel(title: "Loading")
                          : CustomButton(
                              callback: () {
                                _controller.acceptLoanRequest(obj);
                              },
                              width: SizeConfig.widthMultiplier * 95,
                              title: "Accept Loan",
                              txtsize: 20,
                            ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                        thickness: 0.5,
                        color: Colors.grey,
                        height: 50,
                      ),
                      CustomTextbox(
                        width: SizeConfig.widthMultiplier * 95,
                        text: "Rejection reason",
                        maxLine: 5,
                        height: 100,
                        textEditingController:
                            _controller.rejectionController.value,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      CustomButton(
                        callback: () {
                          _controller.rejectLoanRequest(obj);
                        },
                        width: SizeConfig.widthMultiplier * 95,
                        title: "Reject Request",
                        txtsize: 20,
                      )
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
