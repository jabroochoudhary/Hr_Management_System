// To parse this JSON data, do
//
//     final masterSalaryModel = masterSalaryModelFromJson(jsonString);

import 'dart:convert';

MasterSalaryModel masterSalaryModelFromJson(String str) =>
    MasterSalaryModel.fromJson(json.decode(str));

String masterSalaryModelToJson(MasterSalaryModel data) =>
    json.encode(data.toJson());

class MasterSalaryModel {
  MasterSalaryModel({
    this.id,
    this.hrId,
    this.createdAt,
  });

  String? id;
  String? hrId;
  String? createdAt;

  factory MasterSalaryModel.fromJson(Map<String, dynamic> json) =>
      MasterSalaryModel(
        id: json["id"],
        hrId: json["HR_id"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "HR_id": hrId,
        "created_at": createdAt,
      };
}

///////////////////////

DetailsSalaryModel detailsSalaryModelFromJson(String str) =>
    DetailsSalaryModel.fromJson(json.decode(str));

String detailsSalaryModelToJson(DetailsSalaryModel data) =>
    json.encode(data.toJson());

class DetailsSalaryModel {
  DetailsSalaryModel({
    this.id,
    this.empId,
    this.masterId,
    this.empName,
    this.empDesignation,
    this.createdAt,
    this.salary,
    this.isPaid,
  });

  String? id;
  String? empId;
  String? masterId;
  String? empName;
  String? empDesignation;
  String? createdAt;
  String? salary;
  bool? isPaid;

  factory DetailsSalaryModel.fromJson(Map<String, dynamic> json) =>
      DetailsSalaryModel(
        id: json["id"],
        empId: json["emp_id"],
        masterId: json["master_id"],
        empName: json["emp_name"],
        empDesignation: json["emp_designation"],
        createdAt: json["created_at"],
        salary: json["salary"],
        isPaid: json["is_paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_id": empId,
        "master_id": masterId,
        "emp_name": empName,
        "emp_designation": empDesignation,
        "created_at": createdAt,
        "salary": salary,
        "is_paid": isPaid,
      };
}
