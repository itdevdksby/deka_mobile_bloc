
class EmployeeModel {
  String? birthPlace;
  String? costCenterCode;
  String? costCenterDescription;
  String? currentAddress;
  String? currentCity;
  String? currentSubDistrict;
  String? currentVillage;
  String? dateOfBirth;
  String? startDate;
  String? emailAddress;
  String? homePhone;
  String? mobilePhone;
  String? titleCode;
  String? idNumber;
  String? orgLevelDescription;
  String? gradeDescription;
  String? gradeCode;
  String? nik;
  String? name;
  String? status;

  EmployeeModel({
    this.birthPlace,
    this.costCenterCode,
    this.costCenterDescription,
    this.currentAddress,
    this.currentCity,
    this.currentSubDistrict,
    this.currentVillage,
    this.dateOfBirth,
    this.startDate,
    this.emailAddress,
    this.homePhone,
    this.mobilePhone,
    this.titleCode,
    this.idNumber,
    this.orgLevelDescription,
    this.gradeDescription,
    this.gradeCode,
    this.nik,
    this.name,
    this.status,
  });


  factory EmployeeModel.fromJson(dynamic json) {
    return EmployeeModel(
      birthPlace: json['BirthPlace'],
      costCenterCode: json['CostCenterCode'],
      costCenterDescription: json['CostCenterDescription'],
      currentAddress: json['CurrentAddress'],
      currentCity: json['CurrentCity'],
      currentSubDistrict: json['CurrentSubDistrict'],
      currentVillage: json['CurrentVillage'],
      dateOfBirth: json['DateOfBirth'],
      startDate: json['StartDate'],
      emailAddress: json['EmailAddress'],
      homePhone: json['HomePhone'],
      mobilePhone: json['MobilePhone'],
      titleCode: json['TitleCode'],
      idNumber: json['IdNumber'],
      orgLevelDescription: json['OrgLevelDescription'],
      gradeDescription: json['GradeDescription'],
      gradeCode: json['GradeCode'],
      nik: json['NIK'],
      name: json['Name'],
      status: json['Status'],
    );
  }
}