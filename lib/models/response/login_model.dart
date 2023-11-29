

class LoginModel {
  String? username;
  String? password;
  int? userId;
  String? nik;
  String? code;
  String? name;
  String? address;
  String? tempatLahir;
  String? tglLahir;
  String? tglMasuk;
  String? email;
  String? phone1;
  String? phone2;
  String? photo;
  String? photoKtp;
  String? noKtp;
  String? typeuserId;
  String? divisiCode;
  String? jabatanCode;
  String? deviceId;
  String? deviceBrand;
  String? deviceType;
  String? firebaseId;
  String? costCenterCode;
  int? lokasi;
  String? organizationLevel;

  LoginModel({
    this.username,
    this.password,
    this.userId,
    this.nik,
    this.code,
    this.name,
    this.address,
    this.tempatLahir,
    this.tglLahir,
    this.tglMasuk,
    this.email,
    this.phone1,
    this.phone2,
    this.photo,
    this.photoKtp,
    this.noKtp,
    this.typeuserId,
    this.divisiCode,
    this.jabatanCode,
    this.deviceId,
    this.deviceBrand,
    this.deviceType,
    this.firebaseId,
    this.costCenterCode,
    this.lokasi,
    this.organizationLevel
  });


  factory LoginModel.fromJson(dynamic json) {
    return LoginModel(
        username: json['username'],
        password: json['password'],
        userId: json['user_id'],
        nik: json['nik'],
        code: json['code'],
        name: json['name'],
        address: json['address'],
        tempatLahir: json['tempat_lahir'],
        tglLahir: json['tgl_lahir'],
        tglMasuk: json['tgl_masuk'],
        email: json['email'],
        phone1: json['phone_1'],
        phone2: json['phone_2'],
        photo: json['photo'],
        photoKtp: json['photo_ktp'],
        noKtp: json['no_ktp'],
        typeuserId: json['typeuser_id'],
        divisiCode: json['divisi_code'],
        jabatanCode: json['jabatan_code'],
        deviceId: json['device_id'],
        deviceBrand: json['device_brand'],
        deviceType: json['device_type'],
        firebaseId: json['firebase_id'],
        costCenterCode: json['cost_center_code'],
        lokasi: json['lokasi'],
        organizationLevel: json['organization_level'],
    );
  }
}