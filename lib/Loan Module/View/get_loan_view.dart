import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:hr_management_system/Loan%20Module/Components/loan_components.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Loan%20Module/view_model/loan_view_model.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/size_config.dart';

import '../../Utils/custom_button.dart';
import '../../Utils/custom_textbox.dart';

class GetLoanView extends StatelessWidget {
  final _controller = Get.put(LoanViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_sharp),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          // bottomOpacity: 0,
          elevation: 0,
          flexibleSpace: const CustomAppbar(
            text: "Get Loan",
          ),
        ),
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16, top: 10, right: 16),
          child: _controller.selectedAmount.value < 1
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10),
                    // _introCard(),
                    LoanComponents().title('Select Loan Ammount'),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        LoanComponents().menuItem(
                          context,
                          '5,000',
                          blueGradient,
                          onPressed: () {
                            _controller.selectedAmount.value = 5000;
                          },
                        ),
                        LoanComponents().menuItem(
                          context,
                          '10,000',
                          darkRedGradient,
                          onPressed: () {
                            _controller.selectedAmount.value = 10000;
                          },
                        ),
                        LoanComponents().menuItem(
                          context,
                          '20,000',
                          tealGradient,
                          onPressed: () {
                            _controller.selectedAmount.value = 20000;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        LoanComponents().menuItem(
                          context,
                          '50,000',
                          yellowGradient,
                          onPressed: () {
                            _controller.selectedAmount.value = 50000;
                          },
                        ),
                        LoanComponents().menuItem(
                          context,
                          '75,000',
                          redGradient,
                          onPressed: () {
                            _controller.selectedAmount.value = 75000;
                          },
                        ),
                        LoanComponents().menuItem(
                          context,
                          '100,000',
                          purpleGradient,
                          onPressed: () {
                            _controller.selectedAmount.value = 100000;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                    ),

                    // Center(
                    //   child: CustomButton(
                    //     callback: () {
                    //       Navigator.push(context, CustomTransition(LoanRecord()));
                    //     },
                    //     title: "Check Loan",
                    //     width: SizeConfig.widthMultiplier * 70,
                    //   ),
                    // ),
                  ],
                )
              : Column(
                  children: [
                    LoanComponents().title(
                      "Selected loan amount is Rs. ${_controller.selectedAmount.value} only.",
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 4),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 400),
                      child: CustomTextbox(
                        text: "Reason of Loan",
                        maxLine: 5,
                        height: 100,
                        inputType: TextInputType.text,
                        textEditingController: _controller.descController.value,
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 500),
                      child: CustomTextbox(
                        text: "Installments",
                        inputType: TextInputType.number,
                        textEditingController:
                            _controller.installmentsController.value,
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    const DelayedDisplay(
                      delay: Duration(milliseconds: 500),
                      child: Text(
                        "HR will be notified for request of your loan. After approval, the loan installment will deduct from your salary.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 4),
                    Center(
                      child: CustomButton(
                        callback: () {
                          _controller.requestLoan();
                        },
                        title: "Request Loan",
                        width: SizeConfig.widthMultiplier * 87,
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 4),
                    Center(
                      child: CustomButton(
                        callback: () {
                          _controller.selectedAmount.value = 0;
                        },
                        title: "Reset Loan Amount",
                        width: SizeConfig.widthMultiplier * 87,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CustomTransition extends PageRouteBuilder {
  final Widget page;

  CustomTransition(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: page,
          ),
        );
}
