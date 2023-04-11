import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../Loan Module/View/get_loan_view.dart';
import '../../Utils/colors.dart';
import '../../Utils/custom_appbar.dart';
import '../../emp_modules/emp_attendence/view/emp_attendence_view.dart';
import '../components/report_components.dart';
import '../view_model/report_view_model.dart';

class EmployeeReportView extends StatelessWidget {
  EmployeeReportView({super.key});
  final _controller = Get.put(ReportViewModel());

  @override
  Widget build(BuildContext context) {
    _controller.loadReportData();

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
          text: "Report",
        ),
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Salary",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
                ReportComponents().keyLabelRow("Monthly Salary",
                    "Rs. ${_controller.salaryTotalMonth.value}"),
                ReportComponents().keyLabelRow("Yearly Salary",
                    "Rs. ${_controller.salaryTotalYear.value}"),
                Divider(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Attandance",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => EMPAttendenceView()),
                      child: const Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.coloredtext,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Present % of last 30 days",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 8.0,
                      animation: true,
                      percent: _controller.attandencePercentage.value,
                      center: Text(
                        "${_controller.attandencePercentage.value * 100}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Leave % of last 30 days",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 8.0,
                      animation: true,
                      percent: _controller.leavePersentage.value,
                      center: Text(
                        "${_controller.leavePersentage.value * 100}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.yellow,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Absent % of last 30 days",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 8.0,
                      animation: true,
                      percent: _controller.absentPersentage.value,
                      center: Text(
                        "${_controller.absentPersentage.value * 100}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.red,
                    ),
                  ],
                ),
                Divider(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Loan",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => GetLoanView()),
                      child: const Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.coloredtext,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Loan Paid",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 8.0,
                      animation: true,
                      percent: _controller.loanPercentage.value,
                      center: Text(
                        "${_controller.loanPercentage.value * 100}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color.fromARGB(255, 138, 73, 50),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
