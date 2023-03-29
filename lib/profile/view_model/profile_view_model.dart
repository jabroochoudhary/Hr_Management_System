import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as refff;
import 'package:get/get.dart';
import 'package:hr_management_system/Loan%20Module/view_model/loan_view_model.dart';
import 'package:hr_management_system/Sign-Up%20Module/model/sign_up_mode.dart';
import 'package:hr_management_system/Utils/pop_up_notification.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';

import '../../data_classes/local_data_saver.dart';

class ProfileViewModel extends GetxController {
  RxString name = "".obs;
  RxString email = "".obs;
  RxString imageUrl = "".obs;
  RxBool isHR = false.obs;

  RxString companyName = "".obs;
  @override
  void onInit() {
    super.onInit();
    loadUserCloudData();
  }

  AddEmployeeModel? empData;
  SignUpModel? hrData;
  loadUserCloudData() async {
    final uid = (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
    isHR.value =
        (await AppLocalDataSaver.getBool(AppLocalDataSaver.isHRLoginKey))!;
    if (isHR.value) {
      final dt = await loadHRCloudData(uid: uid);
      hrData = dt;
      name.value = dt.userFullName.toString();
      email.value = dt.email.toString();
      companyName.value = dt.companyName.toString();
      imageUrl.value = dt.userProfileLink.toString();
      if (imageUrl.value == "non") {
        imageUrl.value = "";
      }
    } else {
      final dt = await LoanViewModel().loadUserCloudData(uid: uid);
      empData = dt;
      name.value = dt.name.toString();
      email.value = dt.email.toString();
      imageUrl.value = dt.imageURL.toString();
      if (imageUrl.value == "non") {
        imageUrl.value = "";
      }
    }
  }

  setProfileImage(File img) async {
    if (imageUrl.value != "") {
      await deleteImage(imageUrl.value);
      print("Delete image");
    }
    final uImageUrl = await uploadImage(img);
    if (isHR.value) {
      //  await FirebaseFirestore.instance
      //     .collection(AppConstants.hrCollectionName)
      //     .doc(empData!.id)
      //     .update({"image_url": uImageUrl});

      // imageUrl.value = uImageUrl;
    } else {
      await FirebaseFirestore.instance
          .collection(AppConstants.employesCollectionName)
          .doc(empData!.id)
          .update({"image_url": uImageUrl});

      imageUrl.value = uImageUrl;
      empData!.imageURL = imageUrl.value;
      print("Uoloaded done");
      PopUpNotification().show("Image is uloaded to your account.", "Sucess");
    }
  }

  Future<String> uploadImage(File img) async {
    String ids = DateTime.now().microsecondsSinceEpoch.toString();
    refff.Reference reff = refff.FirebaseStorage.instance
        .ref()
        .child("Profile_Images")
        .child("img_$ids");
    await reff.putFile(img);
    return await reff.getDownloadURL();
  }

  deleteImage(String imgurl) async {
    await refff.FirebaseStorage.instance.refFromURL(imgurl).delete();
  }

  Future<SignUpModel> loadHRCloudData({String? uid}) async {
    try {
      final userId;
      if (uid == null) {
        userId = (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
      } else {
        userId = uid;
      }
      // print(userId);

      final dt = await FirebaseFirestore.instance
          .collection(AppConstants.hrCollectionName)
          .doc(userId)
          .get();
      // print(dt.data());
      return SignUpModel.fromJson(dt.data() as Map<String, dynamic>);
    } catch (e) {
      // print(e);
      return SignUpModel();
    }
  }
}
