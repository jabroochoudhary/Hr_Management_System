// To parse this JSON data, do
//
//     final loanMasterModel = loanMasterModelFromJson(jsonString);

import 'dart:convert';

LoanMasterModel loanMasterModelFromJson(String str) =>
    LoanMasterModel.fromJson(json.decode(str));

String loanMasterModelToJson(LoanMasterModel data) =>
    json.encode(data.toJson());

class LoanMasterModel {
  LoanMasterModel({
    this.hrId,
    this.empId,
    this.id,
    this.createdAt,
    this.totalLoan,
    this.installments,
  });

  String? hrId;
  String? empId;
  String? id;
  String? createdAt;
  String? totalLoan;
  String? installments;

  factory LoanMasterModel.fromJson(Map<String, dynamic> json) =>
      LoanMasterModel(
        hrId: json["hr_id"],
        empId: json["emp_id"],
        id: json["id"],
        createdAt: json["created_at"],
        totalLoan: json["total_loan"],
        installments: json["installments"],
      );

  Map<String, dynamic> toJson() => {
        "hr_id": hrId,
        "emp_id": empId,
        "id": id,
        "created_at": createdAt,
        "total_loan": totalLoan,
        "installments": installments,
      };
}
