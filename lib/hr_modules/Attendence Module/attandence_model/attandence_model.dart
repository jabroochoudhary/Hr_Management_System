class AttandenceModel {
  String? empId;
  String? name;
  int? status;
  String? date;
  String? designation;
  AttandenceModel({
    this.empId,
    this.status,
    this.date,
    this.designation,
    this.name,
  });

  AttandenceModel.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    name = json['name'];
    status = json['status'];
    date = json['date'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['emp_id'] = empId;
    data['status'] = status;
    data['name'] = name;
    data['date'] = date;
    data['designation'] = designation;
    return data;
  }
}
