class SaveRekapIzinDomain{
  String? nik;
  String? name;
  String? start_date;
  String? start_date_name;
  String? end_date;
  String? end_date_name;
  String? latitude;
  String? longitude;
  String? start_time;
  String? end_time;
  String? user_id;
  String? reason_type;
  String? reason_type_name;
  String? reason_id;
  String? reason_name;
  String? keterangan;
  String? status_kembali;
  String? photo_1;
  String? photo_1_temp;
  String? photo_2;
  String? photo_3;

  SaveRekapIzinDomain({
    this.nik,
    this.name,
    this.start_date,
    this.start_date_name,
    this.end_date,
    this.end_date_name,
    this.latitude,
    this.longitude,
    this.start_time,
    this.end_time,
    this.user_id,
    this.reason_type,
    this.reason_type_name,
    this.reason_id,
    this.reason_name,
    this.keterangan,
    this.status_kembali,
    this.photo_1_temp,
    this.photo_2,
    this.photo_3,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["nik"] = nik;
    data["name"] = name;
    data["start_date"] = start_date;
    data["end_date"] = end_date;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["start_time"] = start_time;
    data["end_time"] = end_time;
    data["user_id"] = user_id;
    data["reason_type"] = reason_type;
    data["reason_id"] = reason_id;
    data["keterangan"] = keterangan;
    data["status_kembali"] = status_kembali;
    data["photo_1"] = photo_1;
    data["photo_2"] = photo_2;
    data["photo_3"] = photo_3;
    return data;
  }
}