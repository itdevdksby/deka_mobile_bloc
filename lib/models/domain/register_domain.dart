

class RegisterDomain {
  RegisterDomain({
    this.nik,
    this.ktp,
    this.name,
    this.username,
    this.password,
    this.address,
    this.tempat_lahir,
    this.tgl_lahir,
    this.tgl_masuk,
    this.email,
    this.phone_1,
    this.device_id,
    this.device_brand,
    this.device_type,
    this.no_ktp,
    this.foto_ktp,
    this.foto,
    this.foto_temp,
    this.cost_center_code,
    this.cost_center_desc,
    this.jabatan_code,
    this.jabatan_desc,
    this.organization_level,
    this.organization_level_desc,
    this.typeuser_id,
    this.lokasi,
    this.lokasi_desc,
    this.isInfoMatch,
    this.isNewApk,
    this.firebase_id,
  });

  String? nik;
  String? ktp;
  String? name;
  String? username;
  String? password;
  String? address;
  String? tempat_lahir;
  String? tgl_lahir;
  String? tgl_masuk;
  String? email;
  String? phone_1;
  String? device_id;
  String? device_brand;
  String? device_type;
  String? no_ktp;
  String? foto_ktp;
  String? foto;
  String? foto_temp;
  String? cost_center_code;
  String? cost_center_desc;
  String? jabatan_code;
  String? jabatan_desc;
  String? organization_level;
  String? organization_level_desc;
  String? typeuser_id;
  String? lokasi;
  String? lokasi_desc;
  String? isInfoMatch;
  String? isNewApk;
  String? firebase_id = "Unknown";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["nik"] = nik;
    data["ktp"] = ktp;
    data["name"] = name;
    data["username"] = username;
    data["password"] = password;
    data["address"] = address;
    data["tempat_lahir"] = tempat_lahir;
    data["tgl_lahir"] = tgl_lahir;
    data["tgl_masuk"] = tgl_masuk;
    data["email"] = email;
    data["phone_1"] = phone_1;
    data["device_id"] = device_id;
    data["device_brand"] = device_brand;
    data["device_type"] = device_type;
    data["no_ktp"] = no_ktp;
    data["foto_ktp"] = foto_ktp;
    data["foto"] = foto;
    data["cost_center_code"] = cost_center_code;
    data["cost_center_desc"] = cost_center_desc;
    data["jabatan_code"] = jabatan_code;
    data["jabatan_desc"] = jabatan_desc;
    data["organization_level"] = organization_level;
    data["organization_level_desc"] = organization_level_desc;
    data["typeuser_id"] = typeuser_id;
    data["lokasi"] = lokasi;
    data["lokasi_desc"] = lokasi_desc;
    data["firebase_id"] = firebase_id;
    return data;
  }
}