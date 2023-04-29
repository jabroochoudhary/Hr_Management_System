import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/hr_modules/employees_list/components/empoyees_list_components.dart';
import 'package:hr_management_system/hr_modules/employees_list/view_model/employees_list_view_model.dart';
import 'package:hr_management_system/hr_modules/employees_list/views/emp_profile_view.dart';

import '../../../Utils/app_message/toast_message.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/custom_appbar.dart';
import '../../../Utils/loading_indicator.dart';
import '../../../data_classes/constants.dart';

class EmployeesListView extends StatelessWidget {
  EmployeesListView({super.key});
  final _controller = Get.put(EmployeesListViewModel());

  @override
  Widget build(BuildContext context) {
    _controller.loadUserData();
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
            text: "Employees",
          ),
        ),
        body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(AppConstants.employesCollectionName)
                .where("HR_id", isEqualTo: _controller.hrId.value)
                .snapshots(),
            builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.docs.isNotEmpty
                    ? ListView.builder(
                        reverse: false,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final res = snapshot.data!.docs[index];
                          final empData = AddEmployeeModel.fromJson(
                              res.data() as Map<String, dynamic>);

                          return EmployeesListComponents().card(
                            empData,
                            onLongPressed: () async {
                              await ToastMessage().defaultYesNoDialouge(
                                  "Are you sure to delete  ${empData.name} employee. Changes in database is permanent.",
                                  onConfirmPressed: () {
                                _controller.deleteEmployee(
                                    empData.id!, empData.name!);
                                Get.back();
                              }, onCancelPressed: () {
                                Get.back();
                              });
                            },
                            () =>
                                Get.to(() => EmpProfileView(empData: empData)),
                          );
                        },
                      )
                    : const Center(
                        child: Text("No Employee is added yet."),
                      );
              } else {
                return Center(child: LoadingIndicator().loadingWithLabel());
              }
            }),
          ),
        ),
      ),
    );
  }
}
