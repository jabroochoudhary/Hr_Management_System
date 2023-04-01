import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/salary_module/components/salary_components.dart';
import 'package:hr_management_system/salary_module/model/salary_model.dart';
import 'package:hr_management_system/salary_module/view_model/salary_view_model.dart';
import 'package:hr_management_system/salary_module/views/salary_update_view.dart';
import 'package:image_picker/image_picker.dart';
import '../../Utils/colors.dart';
import '../../Utils/custom_appbar.dart';
import '../../Utils/loading_indicator.dart';
import '../../Utils/size_config.dart';
import '../../data_classes/constants.dart';
import 'package:intl/intl.dart';

class SalaryView extends StatelessWidget {
  bool isHr;
  SalaryView({this.isHr = true, super.key});

  DateTime todayDate = DateTime.now();
  final _controller = Get.put(SalaryViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: "Salary",
        ),
      ),
      body: Obx(
        () => Container(
          height: SizeConfig.heightMultiplier * 100,
          width: 400,
          color: Colors.transparent,
          child: _controller.isLoading.value
              ? Center(
                  child: LoadingIndicator().loadingWithLabel(title: "Loading "),
                )
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(AppConstants.salaryMasterCollectionName)
                      .where("HR_id", isEqualTo: _controller.hrID.value)
                      .snapshots(),
                  builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        DateTime now = DateTime.now();
                        String formattedDate =
                            DateFormat('MMMM, yyyy').format(now);
                        return Column(
                          children: [
                            SalaryComponents().card(
                              formattedDate,
                              onPressed: () async {
                                await _controller.createSalary();
                              },
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          // itemCount: 30,
                          itemBuilder: (context, index) {
                            final res = snapshot.data!
                                .docs[snapshot.data!.docs.length - index - 1];

                            ////////////////
                            final masterSalryData = MasterSalaryModel.fromJson(
                                res.data() as Map<String, dynamic>);
                            DateTime now = DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(
                                    masterSalryData.createdAt.toString()));
                            String fdate = DateFormat('MMMM, yyyy').format(now);
                            String nextMonthDate =
                                DateFormat('MMMM, yyyy').format(todayDate);
                            bool nextMonth = false;
                            if (index == 0) {
                              if (todayDate.month - 1 == now.month) {
                                nextMonth = true;
                              } else {
                                nextMonth = false;
                              }
                            }
                            return index == 0
                                ? Column(
                                    children: [
                                      if (nextMonth)
                                        SalaryComponents().card(
                                          "This month: $nextMonthDate",
                                          onPressed: () async {
                                            await _controller.createSalary();
                                          },
                                        ),
                                      SalaryComponents().card(
                                        fdate,
                                        onPressed: () {
                                          Get.to(() => SalaryUpdateView(
                                              masterId: masterSalryData.id
                                                  .toString()));
                                        },
                                      )
                                    ],
                                  )
                                : SalaryComponents().card(
                                    fdate,
                                    onPressed: () {
                                      Get.to(() => SalaryUpdateView(
                                          masterId:
                                              masterSalryData.id.toString()));
                                    },
                                  );
                          },
                        );
                      }
                    } else {
                      return Center(
                        child: LoadingIndicator().loading(),
                      );
                    }
                  }),
                ),
        ),
      ),
    );
  }
}
