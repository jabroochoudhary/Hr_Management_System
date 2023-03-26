// To parse this JSON data, do
//
//     final loanDetailsModel = loanDetailsModelFromJson(jsonString);

import 'dart:convert';

LoanDetailsModel loanDetailsModelFromJson(String str) =>
    LoanDetailsModel.fromJson(json.decode(str));

String loanDetailsModelToJson(LoanDetailsModel data) =>
    json.encode(data.toJson());

class LoanDetailsModel {
  LoanDetailsModel({
    this.masterLoanId,
    this.id,
    this.title,
    this.updatedAt,
    this.ceatedAt,
    this.amount,
    this.isPaid,
  });

  String? masterLoanId;
  String? id;
  String? title;
  String? updatedAt;
  String? ceatedAt;
  String? amount;
  bool? isPaid;

  factory LoanDetailsModel.fromJson(Map<String, dynamic> json) =>
      LoanDetailsModel(
        masterLoanId: json["master_loan_id"],
        id: json["id"],
        title: json["title"],
        updatedAt: json["updated_at"],
        ceatedAt: json["ceated_at"],
        amount: json["amount"],
        isPaid: json["is_paid"],
      );

  Map<String, dynamic> toJson() => {
        "master_loan_id": masterLoanId,
        "id": id,
        "title": title,
        "updated_at": updatedAt,
        "ceated_at": ceatedAt,
        "amount": amount,
        "is_paid": isPaid,
      };
}
