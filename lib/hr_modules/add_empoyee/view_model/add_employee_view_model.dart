import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/pop_up_notification.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';

class AddEmployeeViewModel extends GetxController {
  final nameController = TextEditingController().obs;
  final fnameController = TextEditingController().obs;
  final ageController = TextEditingController().obs;
  final cnicController = TextEditingController().obs;
  final contactController = TextEditingController().obs;

  final educationController = TextEditingController().obs;
  final expertiesController = TextEditingController().obs;
  final designationController = TextEditingController().obs;
  final spouseController = TextEditingController().obs;
  final childrensController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final salaryController = TextEditingController().obs;
  final joiningDateController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  //////////////////////////////////////////

  RxBool isLoading = false.obs;
  ////////////////////////////////////////////
  createEmployeeAccount() async {
    if (nameController.value.text.isNotEmpty &&
        fnameController.value.text.isNotEmpty &&
        ageController.value.text.isNotEmpty &&
        contactController.value.text.isNotEmpty &&
        cnicController.value.text.isNotEmpty &&
        educationController.value.text.isNotEmpty &&
        expertiesController.value.text.isNotEmpty &&
        designationController.value.text.isNotEmpty &&
        spouseController.value.text.isNotEmpty &&
        childrensController.value.text.isNotEmpty &&
        addressController.value.text.isNotEmpty &&
        salaryController.value.text.isNotEmpty &&
        joiningDateController.value.text.isNotEmpty &&
        emailController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty) {
///////////////////////////////////////
      try {
        isLoading.value = true;
        bool done = false;
        String id = DateTime.now().microsecondsSinceEpoch.toString();
        Timestamp createAt = Timestamp.fromDate(DateTime.now());
        String hrid =
            (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
        final data = AddEmployeeModel(
          id: id,
          hrId: hrid,
          address: addressController.value.text,
          age: int.parse(ageController.value.text),
          childrens: int.parse(childrensController.value.text),
          salary: int.parse(salaryController.value.text),
          spouse: int.parse(spouseController.value.text),
          cnic: cnicController.value.text,
          designation: designationController.value.text,
          education: educationController.value.text,
          email: emailController.value.text,
          createdAt: createAt,
          password: passwordController.value.text,
          expertise: expertiesController.value.text,
          fatherName: fnameController.value.text,
          imageURL: "non",
          contact: contactController.value.text,
          joiningDate: joiningDateController.value.text,
          name: nameController.value.text,
        );
        if (await createEmployeeSignInAccount(data)) {
          await FirebaseFirestore.instance
              .collection(AppConstants.employesCollectionName)
              .doc(id)
              .set(data.toJson())
              .then((value) {
            done = true;
          }).timeout(
            Duration(seconds: 10),
            onTimeout: () {
              isLoading.value = false;
              done = false;
            },
          );
        } else {
          isLoading.value = false;
          return;
        }
        if (done) {
          nameController.value.text = "";
          fnameController.value.text = "";
          ageController.value.text = "";
          cnicController.value.text = "";
          educationController.value.text = "";
          expertiesController.value.text = "";
          designationController.value.text = "";
          spouseController.value.text = "";
          childrensController.value.text = "";
          addressController.value.text = "";
          salaryController.value.text = "";
          joiningDateController.value.text = "";
          emailController.value.text = "";
          contactController.value.text = "";
          passwordController.value.text = "";
          PopUpNotification()
              .show("Successfully employee profile is created.", "Sucess");
          isLoading.value = false;
        }
      } on FormatException catch (e) {
        PopUpNotification()
            .show("Wrong input data. Please enter correct data.", "Error");
      } catch (e) {
        print(e);
      }
    } else {
      PopUpNotification()
          .show("Please fill all attributes with proper data", "Information");
    }
    isLoading.value = false;
  }

  Future<bool> createEmployeeSignInAccount(AddEmployeeModel data) async {
    final _auth = FirebaseAuth.instance;
    bool isdone = false;
    if (data.email.toString().isNotEmpty && data.name.toString().isNotEmpty) {
      try {
        final credential = await _auth.createUserWithEmailAndPassword(
            email: data.email.toString(), password: data.password.toString());
        await credential.user!.updateDisplayName(data.name.toString());
        if (credential.user != null) {
          isdone = true;
        } else {
          isdone = false;
        }
      } on FirebaseAuthException catch (e) {
        PopUpNotification().show(e.message.toString(), "Error");
      } catch (e) {
        PopUpNotification()
            .show("Make sure your internet connection is stable.", "Error");
        isdone = false;
      }
    } else {
      isdone = false;
    }
    return isdone;
  }
}
