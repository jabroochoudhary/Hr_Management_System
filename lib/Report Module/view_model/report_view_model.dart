import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_management_system/Loan%20Module/model/loan_details_model.dart';
import 'package:hr_management_system/Loan%20Module/model/loan_master_model.dart';
import 'package:hr_management_system/data_classes/constants.dart';
import 'package:hr_management_system/data_classes/local_data_saver.dart';
import 'package:hr_management_system/hr_modules/Attendence%20Module/attandence_model/attandence_model.dart';
import 'package:hr_management_system/hr_modules/add_empoyee/model/add_empoyee_model.dart';

class ReportViewModel extends GetxController {
  RxString userID = "".obs;
  RxBool isHr = false.obs;

  RxInt totalNoOfEmployees = 0.obs;
  RxInt salaryTotalMonth = 0.obs;
  RxInt salaryTotalYear = 0.obs;
  RxInt minSalaryemp = 0.obs;
  RxInt maxSalaryemp = 0.obs;
  RxDouble attandencePercentage = 0.0.obs;
  RxDouble leavePersentage = 0.0.obs;
  RxDouble absentPersentage = 0.0.obs;
  RxDouble loanPercentage = 0.0.obs;

  loadReportData() async {
    userID.value =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.userId))!;
    isHr.value =
        (await AppLocalDataSaver.getBool(AppLocalDataSaver.isHRLoginKey))!;

    if (isHr.value) {
      loadHrReport();
    } else {
      loadEmployeeReport();
    }
  }

  loadHrReport() async {
    salaryTotalMonth.value = 0;
    salaryTotalYear.value = 0;
    final empData = <AddEmployeeModel>[];
    await FirebaseFirestore.instance
        .collection(AppConstants.employesCollectionName)
        .where("HR_id", isEqualTo: userID.value)
        .get()
        .then((dt) {
      for (var element in dt.docs) {
        empData.add(AddEmployeeModel.fromJson(element.data()));
      }
    });
    totalNoOfEmployees.value = empData.length;
    int minSalary = empData[0].salary!;
    int maxSalary = empData[0].salary!;
    for (var element in empData) {
      salaryTotalMonth.value += element.salary!;
      salaryTotalYear.value = 12 * salaryTotalMonth.value;
      int salary = element.salary!;
      if (salary < minSalary) {
        minSalary = salary;
      }
      if (salary > maxSalary) {
        maxSalary = salary;
      }
    }
    minSalaryemp.value = minSalary;
    maxSalaryemp.value = maxSalary;

    findPresentsAttandence();
    loadLoanReport();
  }

  findPresentsAttandence() async {
    final atPath = FirebaseFirestore.instance
        .collection(AppConstants.hrAttandenceCollection)
        .doc(userID.value)
        .collection(AppConstants.datesCollectionInHrAttandence);
    final dates = await atPath.limit(30).get();
    final datesList = <String>[];
    for (var date in dates.docs) {
      datesList.add(date.id.toString());
    }
    final attendenceList = <AttandenceModel>[];
    for (var id in datesList) {
      final attendence = await atPath
          .doc(id)
          .collection(AppConstants.attendenceInDatesCollectionInHrAttandence)
          .get();
      for (var ate in attendence.docs) {
        attendenceList.add(AttandenceModel.fromJson(ate.data()));
      }
    }
    int empStatusPresentTotal = 0;
    int empStatusAbsenttTotal = 0;
    int empStatusLeaveTotal = 0;
    for (var element in attendenceList) {
      if (element.status! == 1) {
        empStatusPresentTotal += 1;
      }
      if (element.status! == 2) {
        empStatusLeaveTotal += 1;
      }
      if (element.status! == 0) {
        empStatusAbsenttTotal += 1;
      }
    }
    double presencePercentage = (empStatusPresentTotal / attendenceList.length);
    double absentPercentage = (empStatusAbsenttTotal / attendenceList.length);
    double leavePersentages = (empStatusLeaveTotal / attendenceList.length);
    print(absentPercentage);

    leavePersentage.value = double.parse(leavePersentages.toStringAsFixed(2));
    absentPersentage.value = double.parse(absentPercentage.toStringAsFixed(2));
    attandencePercentage.value =
        double.parse(presencePercentage.toStringAsFixed(2));
    print(absentPersentage.value);
  }

  loadLoanReport() async {
    try {
      final loanMasterList = <LoanMasterModel>[];
      final loanDetailsList = <LoanDetailsModel>[];
      await FirebaseFirestore.instance
          .collection(AppConstants.loanMasterCollectionName)
          .where("hr_id", isEqualTo: userID.value)
          .get()
          .then((data) {
        for (var element in data.docs) {
          loanMasterList.add(LoanMasterModel.fromJson(element.data()));
        }
      });
      for (var dt in loanMasterList) {
        await FirebaseFirestore.instance
            .collection(AppConstants.loanDetailsCollectionName)
            .where("master_loan_id", isEqualTo: dt.id)
            .get()
            .then((loans) {
          for (var loan in loans.docs) {
            loanDetailsList.add(LoanDetailsModel.fromJson(loan.data()));
          }
        });
      }
      double totalLoan = 0;
      for (var master in loanMasterList) {
        totalLoan += double.parse(master.totalLoan!);
      }
      double paidLoan = 0;
      for (var loan in loanDetailsList) {
        if (loan.isPaid!) {
          paidLoan += double.parse(loan.amount!);
        }
      }

      double loanp = (paidLoan / totalLoan);

      // print(double.parse(loanp.toStringAsFixed(2)));
      loanPercentage.value = double.parse(loanp.toStringAsFixed(2));
    } catch (e) {
      print(e.toString());
    }
  }

  loadEmployeeReport() async {
    AddEmployeeModel empData;
    final dt = await FirebaseFirestore.instance
        .collection(AppConstants.employesCollectionName)
        .doc(userID.value)
        .get();
    empData = AddEmployeeModel.fromJson(dt.data() as Map<String, dynamic>);
    salaryTotalMonth.value = empData.salary!;
    salaryTotalYear.value = empData.salary! * 12;

    loadEmpAttandece();
    loadEmpLoan();
  }

  loadEmpLoan() async {
    try {
      final loanMasterList = <LoanMasterModel>[];
      final loanDetailsList = <LoanDetailsModel>[];
      await FirebaseFirestore.instance
          .collection(AppConstants.loanMasterCollectionName)
          .where("emp_id", isEqualTo: userID.value)
          .get()
          .then((data) {
        for (var element in data.docs) {
          loanMasterList.add(LoanMasterModel.fromJson(element.data()));
        }
      });
      for (var dt in loanMasterList) {
        await FirebaseFirestore.instance
            .collection(AppConstants.loanDetailsCollectionName)
            .where("master_loan_id", isEqualTo: dt.id)
            .get()
            .then((loans) {
          for (var loan in loans.docs) {
            loanDetailsList.add(LoanDetailsModel.fromJson(loan.data()));
          }
        });
      }
      double totalLoan = 0;
      for (var master in loanMasterList) {
        totalLoan += double.parse(master.totalLoan!);
      }
      double paidLoan = 0;
      for (var loan in loanDetailsList) {
        if (loan.isPaid!) {
          paidLoan += double.parse(loan.amount!);
        }
      }

      double loanp = (paidLoan / totalLoan);

      // print(double.parse(loanp.toStringAsFixed(2)));
      loanPercentage.value = double.parse(loanp.toStringAsFixed(2));
    } catch (e) {
      print(e.toString());
    }
  }

  loadEmpAttandece() async {
    final hrid =
        (await AppLocalDataSaver.getString(AppLocalDataSaver.empHRidKey))!;
    final atPath = FirebaseFirestore.instance
        .collection(AppConstants.hrAttandenceCollection)
        .doc(hrid)
        .collection(AppConstants.datesCollectionInHrAttandence);
    final dates = await atPath.limit(30).get();
    final datesList = <String>[];
    for (var date in dates.docs) {
      datesList.add(date.id.toString());
    }
    final attendenceList = <AttandenceModel>[];
    for (var id in datesList) {
      final attendence = await atPath
          .doc(id)
          .collection(AppConstants.attendenceInDatesCollectionInHrAttandence)
          .where("emp_id", isEqualTo: userID.value)
          .get();
      for (var ate in attendence.docs) {
        attendenceList.add(AttandenceModel.fromJson(ate.data()));
      }
    }
    int empStatusPresentTotal = 0;
    int empStatusAbsenttTotal = 0;
    int empStatusLeaveTotal = 0;
    for (var element in attendenceList) {
      if (element.status! == 1) {
        empStatusPresentTotal += 1;
      }
      if (element.status! == 2) {
        empStatusLeaveTotal += 1;
      }
      if (element.status! == 0) {
        empStatusAbsenttTotal += 1;
      }
    }
    double presencePercentage = (empStatusPresentTotal / attendenceList.length);
    double absentPercentage = (empStatusAbsenttTotal / attendenceList.length);
    double leavePersentages = (empStatusLeaveTotal / attendenceList.length);

    leavePersentage.value = double.parse(leavePersentages.toStringAsFixed(2));
    absentPersentage.value = double.parse(absentPercentage.toStringAsFixed(2));
    attandencePercentage.value =
        double.parse(presencePercentage.toStringAsFixed(2));
  }
}
