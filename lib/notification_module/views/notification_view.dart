import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';
import 'package:hr_management_system/notification_module/components/notification_components.dart';
import 'package:hr_management_system/notification_module/model/notification_model.dart';
import 'package:hr_management_system/notification_module/view_model/notification_view_model.dart';

import '../../Utils/custom_appbar.dart';
import '../../Utils/loading_indicator.dart';
import '../../data_classes/constants.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});
  final _controller = Get.put(NotificationViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
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
              text: "Notifications",
            ),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(AppConstants.notificationCollectionName)
                .where("receiver", isEqualTo: _controller.userId.value)
                .snapshots(),
            builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return !snapshot.data!.docs.isNotEmpty
                    ? ListView.builder(
                        reverse: false,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final res = snapshot.data!.docs[index];

                          final notifi = NotificationModel.fromJson(
                              res.data() as Map<String, dynamic>);

                          return NotificationComponets().card(
                              designation: notifi.designation!,
                              isActive: notifi.isActive!,
                              requestedAt: notifi.createdAt!,
                              senderName: notifi.senderName!,
                              title: notifi.title!);
                        },
                      )
                    : const Center(
                        child: Text("No notification to show"),
                      );
              } else {
                return Center(child: LoadingIndicator().loadingWithLabel());
              }
            }),
          ),
        ));
  }
}
