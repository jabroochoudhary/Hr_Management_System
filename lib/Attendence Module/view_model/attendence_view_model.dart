import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Attendence%20Module/View/attendence.dart';
import 'package:hr_management_system/Attendence%20Module/attandence_model/attandence_model.dart';
import 'package:hr_management_system/add_empoyee/model/add_empoyee_model.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';

class AttendenceViewModel extends GetxController {
  RxString hr_id = "".obs;
  RxBool isHistoryHas = false.obs;

  Future<void> loadUserID() async {
    hr_id.value =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
    // print(hr_id.toString());
  }

  Future<void> setTodayAttandenceSheet({DateTime? dateT}) async {
    if (hr_id.value.isEmpty) {
      await loadUserID();
    }
    // print(hr_id.value);

    final listOfEmployes = <AddEmployeeModel>[];

    DateTime date = DateTime.now();
    if (dateT != null) {
      date = dateT;
    }
    final toDay = "${date.day}-${date.month}-${date.year}";

    final instancePath = await FirebaseFirestore.instance
        .collection(AppConstants.hrAttandenceCollection)
        .doc(hr_id.value)
        .collection(AppConstants.datesCollectionInHrAttandence)
        .doc(toDay)
        .collection(AppConstants.attendenceInDatesCollectionInHrAttandence);
    // final checkData = await instancePath.doc()
    int count = 0;
    await instancePath.get().then((value) {
      count = value.docs.length;
    });
    if (count > 0) {
      print("Today Attandence is Already seted");
    } else {
      await FirebaseFirestore.instance
          .collection(AppConstants.employesCollectionName)
          .get()
          .then((data) {
        for (var dt in data.docs) {
          listOfEmployes.add(AddEmployeeModel.fromJson(dt.data()));
        }
      });
      for (var emp in listOfEmployes) {
        final attData = AttandenceModel(
          name: emp.name,
          date: DateTime.now().microsecondsSinceEpoch.toString(),
          designation: emp.expertise,
          empId: emp.id,
          status: 0,
        );
        await instancePath.doc(emp.id).set(attData.toJson());
      }
      await FirebaseFirestore.instance
          .collection(AppConstants.hrAttandenceCollection)
          .doc(hr_id.value)
          .collection(AppConstants.datesCollectionInHrAttandence)
          .doc(toDay)
          .set({
        'id': toDay,
        'created_at': DateTime.now().microsecondsSinceEpoch.toString(),
      });
      print("Today Attandence Sheet is seted.");
    }
    Get.to(() => AttendencePage(), arguments: {
      "date": toDay,
    });
  }

  Future<void> updateAttandenceStatus(
      String docId, int value, String date) async {
    // final toDay = "${date.day}-${date.month}-${date.year}";

    final instancePath = await FirebaseFirestore.instance
        .collection(AppConstants.hrAttandenceCollection)
        .doc(hr_id.value)
        .collection(AppConstants.datesCollectionInHrAttandence)
        .doc(date)
        .collection(AppConstants.attendenceInDatesCollectionInHrAttandence)
        .doc(docId)
        .update({
      "status": value,
    });
  }

  Future<void> chekDocIsExsist() async {
    if (hr_id.value.isEmpty) {
      await loadUserID();
    }
    try {
      final dt = await FirebaseFirestore.instance
          .collection(AppConstants.hrAttandenceCollection)
          .doc(hr_id.value)
          .get();
      if (dt.id.isNotEmpty) {
        isHistoryHas.value = true;
      } else {
        isHistoryHas.value = false;
      }
    } catch (E) {
      isHistoryHas.value = false;
      print((E.toString() + "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"));
    }
  }

  Future<void> deleteAttandence(String attandenceDate) async {
    final collectionRef = await FirebaseFirestore.instance
        .collection(AppConstants.hrAttandenceCollection)
        .doc(hr_id.value)
        .collection(AppConstants.datesCollectionInHrAttandence)
        .doc(attandenceDate)
        .collection(AppConstants.attendenceInDatesCollectionInHrAttandence);
    var querySnapshot = await await collectionRef.limit(50).get();

    while (querySnapshot.docs.isNotEmpty) {
      WriteBatch writeBatch = FirebaseFirestore.instance.batch();
      querySnapshot.docs.forEach((doc) {
        writeBatch.delete(doc.reference);
        // print(doc.id);
      });
      await writeBatch.commit();
      querySnapshot = await collectionRef.limit(50).get();
    }

    await FirebaseFirestore.instance
        .collection(AppConstants.hrAttandenceCollection)
        .doc(hr_id.value)
        .collection(AppConstants.datesCollectionInHrAttandence)
        .doc(attandenceDate)
        .delete();
    // print("Deleted attandence of $attandenceDate");
  }
}
