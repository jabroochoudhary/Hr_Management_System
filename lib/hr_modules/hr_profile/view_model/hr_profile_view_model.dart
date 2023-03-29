import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as refff;

import '../../../Sign-Up Module/model/sign_up_mode.dart';
import '../../../Utils/pop_up_notification.dart';
import '../../../data_classes/constants.dart';
import '../../../data_classes/local_data_saver.dart';

class HRProfileViewModel extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadHRCloudData();
  }

  RxString name = "".obs;
  RxString email = "".obs;
  RxString imageUrl = "".obs;
  RxBool isHR = false.obs;
  RxString userId = "".obs;

  SignUpModel? hrData;

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
          .collection(AppConstants.hrCollectionName)
          .doc(userId.value)
          .update({"user_profile_link": uImageUrl});

      imageUrl.value = uImageUrl;
      hrData!.userProfileLink = imageUrl.value;
      print("Uploaded done");
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
      if (uid == null) {
        userId.value =
            (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
      } else {
        userId.value = uid;
      }
      // print(userId);

      final dt = await FirebaseFirestore.instance
          .collection(AppConstants.hrCollectionName)
          .doc(userId.value)
          .get();
      // print(dt.data());
      final data = SignUpModel.fromJson(dt.data() as Map<String, dynamic>);
      imageUrl.value = data.userProfileLink.toString();

      return data;
    } catch (e) {
      // print(e);
      return SignUpModel();
    }
  }
}
