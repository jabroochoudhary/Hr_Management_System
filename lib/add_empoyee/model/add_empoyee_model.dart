import 'package:cloud_firestore/cloud_firestore.dart';

class AddEmployeeModel {
  String? id;
  String? name;
  String? fatherName;
  int? age;
  String? cnic;
  String? education;
  String? expertise;
  String? designation;
  int? spouse;
  int? childrens;
  String? address;
  int? salary;
  String? joiningDate;
  String? email;
  String? password;
  String? imageURL;
  String? contact;
  String? hrId;
  Timestamp? createdAt;

  AddEmployeeModel(
      {this.id,
      this.name,
      this.fatherName,
      this.age,
      this.cnic,
      this.education,
      this.expertise,
      this.designation,
      this.spouse,
      this.hrId,
      this.childrens,
      this.address,
      this.salary,
      this.joiningDate,
      this.email,
      this.createdAt,
      this.contact,
      this.imageURL,
      this.password});

  AddEmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fatherName = json['father_name'];
    age = json['age'];
    cnic = json['cnic'];
    education = json['education'];
    expertise = json['expertise'];
    designation = json['designation'];
    spouse = json['spouse'];
    childrens = json['childrens'];
    address = json['address'];
    salary = json['salary'];
    joiningDate = json['joining_date'];
    email = json['email'];
    password = json['password'];
    imageURL = json['image_url'];
    contact = json['contact_no'];
    hrId = json['HR_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['HR_id'] = hrId;

    data['name'] = name;
    data['father_name'] = fatherName;
    data['age'] = age;
    data['cnic'] = cnic;
    data['education'] = education;
    data['expertise'] = expertise;
    data['designation'] = designation;
    data['spouse'] = spouse;
    data['childrens'] = childrens;
    data['address'] = address;
    data['salary'] = salary;
    data['joining_date'] = joiningDate;
    data['email'] = email;
    data['password'] = password;
    data['image_url'] = imageURL;
    data['contact_no'] = contact;
    data['created_at'] = createdAt;

    return data;
  }
}
