import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hr_management_system/Home%20Module/View/home_screen.dart';
import 'package:hr_management_system/Sign-Up%20Module/model/sign_up_mode.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/data_classes/constants.dart';

import '../../Utils/pop_up_notification.dart';
import '../../data_classes/local_data_saver.dart';

class LogInViewModel extends GetxController {
  RxBool isLoading = false.obs;
  final useremailController = TextEditingController().obs;
  final userpasswordController = TextEditingController().obs;
  final userNameController = TextEditingController().obs;
////////////////////////////////////
  RxString userId = "".obs;
  RxBool isHrCheck = true.obs;

  ////////////////////////////////
  ////  Google sign up implementatin
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  lognInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleSignInAcoount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAcoount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // all below is for checking
      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);
      final User? curruntUser = _auth.currentUser;
      assert(curruntUser!.uid == user!.uid);
      // print(user);
      if (user!.uid.toString() != "") {
        userNameController.value.text = user.displayName.toString();
        useremailController.value.text = user.email.toString();
        userId.value = user.uid.toString();

        if (await isUserProfileComplete(userId.toString())) {
          Get.off(() => HomeScreen(isHrCheck.value));
        } else {
          PopUpNotification()
              .show("Complete your profile to continue.", "Info");
        }

        isLoading.value = false;
      }
      // print(userId.toString());
    } on FirebaseException catch (e) {
      print("Error ================" + e.toString());
      PopUpNotification().show(e.message.toString(), "Error");
      Get.back();
    } on GoogleSignIn catch (e) {
      print("Error ================" + e.toString());
      PopUpNotification().show(e.toString(), "Error");
      Get.back();
    }
  }

/////////////////////////////////////////////
  loigInWithEmailPassword() async {
    bool isDone = false;
    try {
      if (useremailController.value.text.isNotEmpty &&
          userpasswordController.value.text.isNotEmpty) {
        User? user;
        isLoading.value = true;

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: useremailController.value.text,
                password: userpasswordController.value.text)
            .then((value) {
          user = value.user!;

          isDone = true;
        }).timeout(
          const Duration(
            seconds: 10,
          ),
          onTimeout: () {
            PopUpNotification().show("Bad internet connection.", "Info");
          },
        );
        if (isDone && user != null) {
          userId.value = user!.uid.toString();
          if (await isUserProfileComplete(userId.value)) {
            Get.off(() => HomeScreen(isHrCheck.value));
          } else {
            isLoading.value = false;
            PopUpNotification()
                .show("Complete your profile to continue.", "Info");
          }
        } else {
          PopUpNotification().show("Something went wrong.", "Info");
        }
      } else {
        PopUpNotification()
            .show("Enter username and password correctly.", "Info");
      }
    } on FirebaseAuthException catch (e) {
      PopUpNotification().show(e.message.toString(), "Error");
    } on FirebaseException catch (e) {
      PopUpNotification().show(e.toString(), "Error");
    } on Exception catch (e) {
      PopUpNotification().show(e.toString(), "Error");
    } catch (e) {
      PopUpNotification().show(e.toString(), "Error");
    }
    isLoading.value = false;
  }

//////////////////////////////////////
  Future<bool> isUserProfileComplete(String uid) async {
    if (isHrCheck.value) {
      SignUpModel userData = SignUpModel();
      try {
        await FirebaseFirestore.instance
            .collection(AppConstants.hrCollectionName)
            .doc(uid)
            .get()
            .then((value) {
          userData = SignUpModel.fromJson(value.data() as Map<String, dynamic>);
        }).timeout(Duration(seconds: 10));
        if (userData.email!.isNotEmpty) {
          await AppLocalDataSaver.setString(
              userData.email.toString(), AppLocalDataSaver.userEmail);
          await AppLocalDataSaver.setString(
              uid.toString(), AppLocalDataSaver.userId);
          await AppLocalDataSaver.setString(
              userData.userFullName.toString(), AppLocalDataSaver.userName);
          await AppLocalDataSaver.setBool(
              isHrCheck.value, AppLocalDataSaver.isHRLoginKey);

          return true;
        } else {
          return false;
        }
      } catch (e) {}
      return false;
    } else {
      // print("Employee");
      AddEmployeeModel userData = AddEmployeeModel();
      try {
        await FirebaseFirestore.instance
            .collection(AppConstants.employesCollectionName)
            .where("email", isEqualTo: useremailController.value.text)
            .where("password", isEqualTo: userpasswordController.value.text)
            .get()
            .then((value) {
          userData = AddEmployeeModel.fromJson(value.docs[0].data());
        }).timeout(Duration(seconds: 10));
        if (userData.email!.isNotEmpty) {
          await AppLocalDataSaver.setString(
              userData.email.toString(), AppLocalDataSaver.userEmail);
          await AppLocalDataSaver.setString(
              userData.id.toString(), AppLocalDataSaver.userId);
          await AppLocalDataSaver.setString(
              userData.name.toString(), AppLocalDataSaver.userName);
          await AppLocalDataSaver.setString(
              userData.hrId.toString(), AppLocalDataSaver.empHRidKey);
          await AppLocalDataSaver.setBool(
              isHrCheck.value, AppLocalDataSaver.isHRLoginKey);

          return true;
        } else {
          return false;
        }
      } catch (e) {}
      return false;
    }
  }

//////////////////////////////////////////////////
  ///
  forgetPassword() async {}
}
