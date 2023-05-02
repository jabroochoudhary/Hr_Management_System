import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_management_system/Sign-Up%20Module/model/sign_up_mode.dart';
import 'package:hr_management_system/Utils/pop_up_notification.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';

class SignUpViewModel extends GetxController {
  RxBool isSignUpGoogleDone = false.obs;
  RxBool isLoading = false.obs;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isSignUpGoogleDone.value = false;
    print("Dispose");
  }

  //////////////////////
  final userNameController = TextEditingController().obs;
  final useremailController = TextEditingController().obs;
  final userpasswordController = TextEditingController().obs;
  final userageController = TextEditingController().obs;
  //////////////////////
  final companyAddressController = TextEditingController().obs;
  final companyNameController = TextEditingController().obs;
  final companyDomainController = TextEditingController().obs;
  final officePhoneNoController = TextEditingController().obs;
  final userContactNoController = TextEditingController().obs;

  RxString userId = "".obs;

  ////  Google sign up implementatin
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  signupWithGoogle() async {
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
        userContactNoController.value.text = user.phoneNumber.toString();

        if (await isUserProfileComplete(userId.value)) {
          isLoading.value = false;
          Get.back();
          PopUpNotification()
              .show("Your profile is completed. Log in to continue", "Info");
        } else {
          isSignUpGoogleDone.value = true;
          isLoading.value = false;
        }
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
    } catch (e) {
      PopUpNotification().show(e.toString(), "Error");
    }
  }

  Future<bool> saveSignUpUserData() async {
    bool done = false;
    if (userNameController.value.text.isNotEmpty &&
        useremailController.value.text.isNotEmpty &&
        userpasswordController.value.text.isNotEmpty &&
        userageController.value.text.isNotEmpty &&
        companyAddressController.value.text.isNotEmpty &&
        companyDomainController.value.text.isNotEmpty &&
        companyNameController.value.text.isNotEmpty &&
        officePhoneNoController.value.text.isNotEmpty &&
        userContactNoController.value.text.isNotEmpty) {
      isLoading.value = true;
      final data = SignUpModel(
        age: int.parse(userageController.value.text),
        companyAddress: companyAddressController.value.text,
        companyDomain: companyDomainController.value.text,
        companyName: companyNameController.value.text,
        email: useremailController.value.text,
        officePhoneNo: officePhoneNoController.value.text,
        password: userpasswordController.value.text,
        personalContactNo: userContactNoController.value.text,
        userFullName: userNameController.value.text,
        userProfileLink: "non",
      );
      try {
        await FirebaseFirestore.instance
            .collection(AppConstants.hrCollectionName)
            .doc(userId.toString())
            .set(data.toJson())
            .whenComplete(() {
          done = true;
        }).timeout(
          Duration(seconds: 10),
          onTimeout: () {
            isLoading.value = false;
            done = false;
          },
        );
        if (done) {
          AuthCredential credential = EmailAuthProvider.credential(
              email: useremailController.value.text,
              password: userpasswordController.value.text);

          await FirebaseAuth.instance.currentUser
              ?.linkWithCredential(credential);

          await AppLocalDataSaver.setString(
              userNameController.value.text.toString(),
              AppLocalDataSaver.userName);
          await AppLocalDataSaver.setString(
              useremailController.value.text.toString(),
              AppLocalDataSaver.userEmail);
          await AppLocalDataSaver.setString(
              userId.value.toString(), AppLocalDataSaver.userId);
        }
        isLoading.value = false;
        Get.back();
        PopUpNotification().show("Profile completed sucess", "Profile");

        return done;
      } catch (e) {
        print(e.toString());
        return false;
      }
    }
    isLoading.value = false;
    return done;
  }

  Future<bool> isUserProfileComplete(String uid) async {
    bool isDone = false;
    SignUpModel userData = SignUpModel();
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.hrCollectionName)
          .doc(uid)
          .get()
          .then((value) {
        userData = SignUpModel.fromJson(value.data() as Map<String, dynamic>);
        isDone = true;
      }).timeout(
        Duration(seconds: 5),
        onTimeout: () {
          isDone = false;
        },
      );
      if (userData.email!.isNotEmpty) {
        await AppLocalDataSaver.setString(
            userData.email.toString(), AppLocalDataSaver.userEmail);
        await AppLocalDataSaver.setString(
            uid.toString(), AppLocalDataSaver.userId);
        await AppLocalDataSaver.setString(
            userData.userFullName.toString(), AppLocalDataSaver.userName);

        return isDone;
      } else {
        return isDone;
      }
    } catch (e) {}
    return false;
  }

  updateHRAccount(SignUpModel hrData) async {
    if (userNameController.value.text.isNotEmpty &&
        useremailController.value.text.isNotEmpty &&
        userpasswordController.value.text.isNotEmpty &&
        userageController.value.text.isNotEmpty &&
        companyAddressController.value.text.isNotEmpty &&
        companyDomainController.value.text.isNotEmpty &&
        companyNameController.value.text.isNotEmpty &&
        officePhoneNoController.value.text.isNotEmpty &&
        userContactNoController.value.text.isNotEmpty) {
      isLoading.value = true;
      final hrid =
          (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;

      hrData.userFullName = userNameController.value.text;
      hrData.age = int.parse(userageController.value.text);
      hrData.companyAddress = companyAddressController.value.text;
      hrData.officePhoneNo = officePhoneNoController.value.text;
      hrData.personalContactNo = userContactNoController.value.text;

      await FirebaseFirestore.instance
          .collection(AppConstants.hrCollectionName)
          .doc(hrid)
          .update(hrData.toJson());

      isLoading.value = false;
      Get.back();
      PopUpNotification().show("Profile is updated sucess", "Profile");
    } else {
      isLoading.value = false;
      PopUpNotification().show("Please enter proper fields data.", "Alert");
    }
  }
}
