import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/hr_modules/employees_list/views/edit_employee_view.dart';
import 'package:hr_management_system/profile/components/profile_components.dart';

class EmpProfileView extends StatelessWidget {
  AddEmployeeModel empData;
  EmpProfileView({required this.empData, Key? key}) : super(key: key);

  // final _controller = Get.find<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: InkWell(
                      onTap: () {
                        imageShowDialogue(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: empData.imageURL == "non"
                            ? const Image(
                                image: AssetImage(
                                    "assets/profile_pic_side_menu.png"),
                              )
                            : Image(
                                image: NetworkImage(empData.imageURL!),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                empData.name.toString(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(empData.email.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    Get.off(() => EditEmployeeView(
                          empData: empData,
                        ));
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
                      ProfileComponents()
                          .card("Designation", empData.designation),
                      ProfileComponents().card("Experties", empData.expertise),
                      ProfileComponents().card("Education", empData.education),
                      ProfileComponents()
                          .card("Salary", "Rs. ${empData.salary}"),
                      ProfileComponents()
                          .card("Joining Date", empData.joiningDate),
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
                      ProfileComponents()
                          .card("Father name", empData.fatherName),
                      ProfileComponents().card("Age", empData.age.toString()),
                      ProfileComponents().card("CNIC", empData.cnic),
                      ProfileComponents().card("Contact No.", empData.contact),
                      ProfileComponents()
                          .card("Address", empData.address.toString()),
                      ProfileComponents()
                          .card("Spouse", empData.spouse.toString()),
                      ProfileComponents()
                          .card("Children", empData.childrens.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  imageShowDialogue(BuildContext context) {
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
            image: empData.imageURL == "non"
                ? const DecorationImage(
                    image: AssetImage("assets/profile_pic_side_menu.png"),
                  )
                : DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(empData.imageURL!),
                  )),
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
