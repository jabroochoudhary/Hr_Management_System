import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hr_management_system/Utils/loading_indicator.dart';
import 'package:hr_management_system/Utils/textbox_with_label.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/add_empoyee/view_model/add_employee_view_model.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final _controllerAddEmployee = Get.put(AddEmployeeViewModel());
  @override
  Widget build(BuildContext context) {
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
          flexibleSpace: CustomAppbar(
            text: "Add Employee",
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // margin: EdgeInsets.only(top: SizeConfig.heightMultiplier*10),
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                const Text("Employee Information",
                    style: TextStyle(
                        color: AppColors.coloredtext,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.start),
                const SizedBox(height: 10),
                TextFieldWithLabel().textFieldLabel(
                  label: "Name",
                  hint: "Husnain",
                  textEditingController:
                      _controllerAddEmployee.nameController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Father Name",
                  hint: "Shah",
                  textEditingController:
                      _controllerAddEmployee.fnameController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Age",
                  hint: "22",
                  isNumber: true,
                  textEditingController:
                      _controllerAddEmployee.ageController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "CNIC",
                  hint: "36603-00000000-0",
                  textEditingController:
                      _controllerAddEmployee.cnicController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Contact",
                  hint: "+923123456789",
                  textEditingController:
                      _controllerAddEmployee.contactController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Education",
                  hint: "BS Computer Science",
                  textEditingController:
                      _controllerAddEmployee.educationController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Expertise",
                  hint: "Flull stack flutter developer",
                  textEditingController:
                      _controllerAddEmployee.expertiesController.value,
                ),
                const SizedBox(height: 10),
                const Text("Personal Information",
                    style: TextStyle(
                        color: AppColors.coloredtext,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.start),
                const SizedBox(height: 10),
                TextFieldWithLabel().textFieldLabel(
                  label: "Spouse",
                  hint: "1",
                  isNumber: true,
                  textEditingController:
                      _controllerAddEmployee.spouseController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "No of Dependent Children",
                  hint: "3",
                  isNumber: true,
                  textEditingController:
                      _controllerAddEmployee.childrensController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Address",
                  hint: "Complete address",
                  maxLines: 3,
                  textEditingController:
                      _controllerAddEmployee.addressController.value,
                ),
                const SizedBox(height: 10),
                const Text("Hr Section",
                    style: TextStyle(
                        color: AppColors.coloredtext,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.start),
                const SizedBox(height: 10),
                TextFieldWithLabel().textFieldLabel(
                  label: "Designation",
                  hint: "Flutter Developer",
                  textEditingController:
                      _controllerAddEmployee.designationController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Monthly Salary",
                  hint: "Ammount PkR e.g. 75000",
                  isNumber: true,
                  textEditingController:
                      _controllerAddEmployee.salaryController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Joining Date",
                  hint: "Tab to select date",
                  textEditingController:
                      _controllerAddEmployee.joiningDateController.value,
                  isReadOnly: true,
                  onTap: () => DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2015, 1, 1),
                    maxTime: DateTime.now(),
                    theme: const DatePickerTheme(
                      cancelStyle: TextStyle(
                          color: AppColors.textlight,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                      doneStyle: TextStyle(
                          color: AppColors.coloredtext,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    onChanged: (date) {
                      _controllerAddEmployee.joiningDateController.value.text =
                          "${date.day}-${date.month}-${date.year}";
                    },
                    onConfirm: (date) {
                      _controllerAddEmployee.joiningDateController.value.text =
                          "${date.day}-${date.month}-${date.year}";
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                  ),
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Employee Email",
                  hint: "husnain.shah@company.com",
                  textEditingController:
                      _controllerAddEmployee.emailController.value,
                ),
                TextFieldWithLabel().textFieldLabel(
                  label: "Employee Password",
                  hint: "password atleast 6 charecters long",
                  textEditingController:
                      _controllerAddEmployee.passwordController.value,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                      "By using this credential, employee can chek his/her status",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Container(
                  padding: EdgeInsets.only(left: 13, right: 13),
                  child: _controllerAddEmployee.isLoading.value
                      ? Center(child: LoadingIndicator().loading())
                      : CustomButton(
                          callback: () {
                            // Navigator.push(
                            //   context,
                            //   CustomTransition(
                            //     PersonalInformation(),
                            //   ),
                            // );
                            FocusScope.of(context).unfocus();

                            _controllerAddEmployee.createEmployeeAccount();
                          },
                          title: "Create Employee Account",
                          width: SizeConfig.widthMultiplier * 100,
                        ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomTransition extends PageRouteBuilder {
//   final Widget page;

//   CustomTransition(this.page)
//       : super(;
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               FadeTransition(
//             opacity: animation,
//             child: page,
//           ),
//         );
// }
