import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/view/add_employee.dart';
import 'package:hr_management_system/profile/components/profile_components.dart';
import 'package:hr_management_system/profile/view_model/profile_view_model.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = Get.find<ProfileViewModel>();

  ////////////////////////// image picker

  File? _image;

  final picker = ImagePicker();

  Future pickImage(ImageSource src) async {
    final pick = await picker.pickImage(source: src);
    if (pick != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pick.path,
        // aspectRatioPresets: [
        //   CropAspectRatioPreset.square,
        //   CropAspectRatioPreset.original,
        // ],
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.primarycolor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
        maxHeight: 300,
        maxWidth: 300,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        cropStyle: CropStyle.rectangle,
      );
      if (croppedFile != null) {
        _image = File(croppedFile.path);
        _controller.setProfileImage(_image!);
        setState(() {
          _image = File(croppedFile.path);
          print("image cropped and set");
        });
      }
    }
  }

  ///////////////////////////////End image picker

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    print(_controller.imageUrl.value);

    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 70),
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: InkWell(
                        onTap: () {
                          imageShowDialogue();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _controller.imageUrl.value == ""
                              ? _image == null
                                  ? const Image(
                                      image: AssetImage(
                                          "assets/profile_pic_side_menu.png"),
                                    )
                                  : Image(
                                      image: FileImage(_image!),
                                    )
                              : Image(
                                  image:
                                      NetworkImage(_controller.imageUrl.value),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          ProfileComponents().sheet(
                            context: context,
                            gallaryPressed: () async {
                              Get.back();
                              await pickImage(ImageSource.gallery);
                            },
                            cameraPressed: () {
                              Get.back();

                              pickImage(ImageSource.camera);
                            },
                            cancelPressed: () => Get.back(),
                          );
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.primarycolor),
                          child: const Icon(
                            LineAwesomeIcons.alternate_pencil,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _controller.empData!.name.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(_controller.empData!.email.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Get.to(
                        () => SignupScreen(
                          empData: _controller.empData,
                          isHR: _controller.isHR.value,
                        ),
                      );
                      await _controller.loadUserCloudData();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primarycolor,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 89, 136, 183),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Office Information",
                          style: TextStyle(
                            color: AppColors.textlight,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ProfileComponents().card(
                            "Designation", _controller.empData!.designation),
                        ProfileComponents()
                            .card("Experties", _controller.empData!.expertise),
                        ProfileComponents()
                            .card("Education", _controller.empData!.education),
                        ProfileComponents().card(
                            "Salary", "Rs. ${_controller.empData!.salary}"),
                        ProfileComponents().card(
                            "Joining Date", _controller.empData!.joiningDate),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DelayedDisplay(
                  delay: Duration(milliseconds: 800),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 89, 136, 183),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                            color: AppColors.textlight,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ProfileComponents().card(
                            "Father name", _controller.empData!.fatherName),
                        ProfileComponents()
                            .card("Age", _controller.empData!.age.toString()),
                        ProfileComponents()
                            .card("CNIC", _controller.empData!.cnic),
                        ProfileComponents()
                            .card("Contact No.", _controller.empData!.contact),
                        ProfileComponents().card(
                            "Address", _controller.empData!.address.toString()),
                        ProfileComponents().card(
                            "Spouse", _controller.empData!.spouse.toString()),
                        ProfileComponents().card("Children",
                            _controller.empData!.childrens.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  imageShowDialogue() {
    return Get.defaultDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      title: "",
      titleStyle: TextStyle(fontSize: 1),
      barrierDismissible: false,
      content: Container(
        height: MediaQuery.of(context).size.width * 0.92,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          image: _image == null
              ? _controller.imageUrl.value == ""
                  ? const DecorationImage(
                      image: AssetImage("assets/profile_pic_side_menu.png"),
                    )
                  : DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(_controller.imageUrl.value),
                    )
              : DecorationImage(
                  image: FileImage(_image!),
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.close,
                size: 30,
                color: AppColors.primarycolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
