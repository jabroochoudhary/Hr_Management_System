import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:hr_management_system/Utils/loading_indicator.dart';
import 'package:hr_management_system/Utils/textbox_with_label.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/custom_appbar.dart';
import 'package:hr_management_system/Utils/custom_button.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/size_config.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/view_model/add_employee_view_model.dart';
import 'package:hr_management_system/hr_modules/employees_list/view_model/employees_list_view_model.dart';
import 'package:hr_management_system/hr_modules/employees_list/views/employees_list_view.dart';

class EditEmployeeView extends StatelessWidget {
  AddEmployeeModel? empData;

  EditEmployeeView({
    this.empData,
    Key? key,
  }) : super(key: key);
  final _controllerAddEmployee = Get.put(EmployeesListViewModel());

  @override
  Widget build(BuildContext context) {
    try {
      _controllerAddEmployee.isLoading.value = false;

      if (empData != null) {
        _controllerAddEmployee.fnameController.value.text =
            empData!.fatherName.toString();
        _controllerAddEmployee.nameController.value.text =
            empData!.name.toString();
        _controllerAddEmployee.emailController.value.text =
            empData!.email.toString();
        _controllerAddEmployee.passwordController.value.text =
            empData!.password.toString();
        _controllerAddEmployee.cnicController.value.text =
            empData!.cnic.toString();
        _controllerAddEmployee.ageController.value.text =
            empData!.age.toString();
        _controllerAddEmployee.addressController.value.text =
            empData!.address.toString();
        _controllerAddEmployee.contactController.value.text =
            empData!.contact.toString();
        _controllerAddEmployee.educationController.value.text =
            empData!.education.toString();
        _controllerAddEmployee.fnameController.value.text =
            empData!.fatherName.toString();
        _controllerAddEmployee.expertiesController.value.text =
            empData!.expertise.toString();
        _controllerAddEmployee.spouseController.value.text =
            empData!.spouse.toString();
        _controllerAddEmployee.salaryController.value.text =
            empData!.salary.toString();
        _controllerAddEmployee.designationController.value.text =
            empData!.designation.toString();
        _controllerAddEmployee.joiningDateController.value.text =
            empData!.joiningDate.toString();
        _controllerAddEmployee.childrensController.value.text =
            empData!.childrens.toString();
      }
    } catch (e) {
      print(e.toString());
    }
    return ProgressHUD(
      child: Builder(
        builder: (context) => Obx(
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
                text: "Employee",
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
                      isReadOnly: true,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "Father Name",
                      hint: "Shah",
                      isReadOnly: true,
                      textEditingController:
                          _controllerAddEmployee.fnameController.value,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "Age",
                      hint: "22",
                      isNumber: true,
                      textEditingController:
                          _controllerAddEmployee.ageController.value,
                      isReadOnly: true,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "CNIC",
                      hint: "36603-00000000-0",
                      isReadOnly: true,
                      textEditingController:
                          _controllerAddEmployee.cnicController.value,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "Contact",
                      hint: "+923123456789",
                      isReadOnly: false,
                      textEditingController:
                          _controllerAddEmployee.contactController.value,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "Education",
                      hint: "BS Computer Science",
                      isReadOnly: false,
                      textEditingController:
                          _controllerAddEmployee.educationController.value,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "Expertise",
                      hint: "Flull stack flutter developer",
                      isReadOnly: false,
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
                      isReadOnly: true,
                      textEditingController:
                          _controllerAddEmployee.spouseController.value,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "No of Dependent Children",
                      hint: "3",
                      isNumber: true,
                      isReadOnly: true,
                      textEditingController:
                          _controllerAddEmployee.childrensController.value,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "Address",
                      hint: "Complete address",
                      maxLines: 3,
                      isReadOnly: true,
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
                      isReadOnly: false,
                      textEditingController:
                          _controllerAddEmployee.designationController.value,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "Monthly Salary",
                      hint: "Ammount PkR e.g. 75000",
                      isReadOnly: false,
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
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "Employee Email",
                      isReadOnly: true,
                      hint: "husnain.shah@company.com",
                      textEditingController:
                          _controllerAddEmployee.emailController.value,
                    ),
                    TextFieldWithLabel().textFieldLabel(
                      label: "Employee Password",
                      isReadOnly: true,
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
                                _controllerAddEmployee
                                    .updateEmployeeSideAccount(empData!);
                              },
                              title: "Update Account",
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
        ),
      ),
    );
  }
}
