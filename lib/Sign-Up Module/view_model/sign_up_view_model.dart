import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';

class SignUpViewModel extends GetxController {
  RxBool isSignUpGoogleDone = false.obs;
  RxBool isLoading = false.obs;

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
        await AppLocalDataSaver.setString(
            user.displayName.toString(), AppLocalDataSaver.userName);
        await AppLocalDataSaver.setString(
            user.email.toString(), AppLocalDataSaver.userEmail);
        await AppLocalDataSaver.setString(
            user.uid.toString(), AppLocalDataSaver.userId);

        userNameController.value.text = user.displayName.toString();
        useremailController.value.text = user.email.toString();
        userId.value = user.uid.toString();
        userContactNoController.value.text = user.phoneNumber.toString();

        isSignUpGoogleDone.value = true;
        isLoading.value = false;
      }
    } on FirebaseException catch (e) {
      print("Error ================" + e.toString());
    } on GoogleSignIn catch (e) {
      print("Error ================" + e.toString());
    }
  }
}
