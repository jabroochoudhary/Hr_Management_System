class SignUpModel {
  String? email;
  String? password;
  int? age;
  String? companyName;
  String? companyAddress;
  String? companyDomain;
  String? officePhoneNo;
  String? personalContactNo;
  String? userFullName;
  String? userProfileLink;

  SignUpModel(
      {this.email,
      this.password,
      this.age,
      this.companyName,
      this.companyAddress,
      this.companyDomain,
      this.officePhoneNo,
      this.personalContactNo,
      this.userProfileLink,
      this.userFullName});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    age = json['age'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyDomain = json['company_domain'];
    officePhoneNo = json['office_phone_no'];
    personalContactNo = json['personal_contact_no'];
    userFullName = json['user_full_name'];
    userProfileLink = json['user_profile_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    data['age'] = age;
    data['company_name'] = companyName;
    data['company_address'] = companyAddress;
    data['company_domain'] = companyDomain;
    data['office_phone_no'] = officePhoneNo;
    data['personal_contact_no'] = personalContactNo;
    data['user_full_name'] = userFullName;
    data['user_profile_link'] = userProfileLink;

    return data;
  }
}
