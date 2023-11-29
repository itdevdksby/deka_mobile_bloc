class RekapIzinModel {
  String? code;
  String? jpayrollId;
  String? name;
  String? nik;
  String? costCenterCode;
  String? reasonType;
  String? reasonId;
  String? potongCuti;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? lamaCuti;
  String? tglBatal;
  String? latitude;
  String? longitude;
  String? jamKembali;
  String? photo1;
  String? photo2;
  String? photo3;
  String? keterangan;
  String? status;
  String? statusApproval;
  String? statusKembali;
  String? statusBatal;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? reasonName;
  String? reasonTypeName;
  String? userApproval;
  String? descApproval;

  RekapIzinModel({
    this.code,
    this.jpayrollId,
    this.name,
    this.nik,
    this.costCenterCode,
    this.reasonType,
    this.reasonId,
    this.potongCuti,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.lamaCuti,
    this.tglBatal,
    this.latitude,
    this.longitude,
    this.jamKembali,
    this.photo1,
    this.photo2,
    this.photo3,
    this.keterangan,
    this.status,
    this.statusApproval,
    this.statusKembali,
    this.statusBatal,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.reasonName,
    this.reasonTypeName,
    this.userApproval,
    this.descApproval,
  });

  factory RekapIzinModel.fromJson(Map<String, dynamic> json) {
    return RekapIzinModel(
      code: json['code'],
      jpayrollId: json['jpayroll_id'],
      name: json['name'],
      nik: json['nik'],
      costCenterCode: json['cost_center_code'],
      reasonType: json['reason_type'],
      reasonId: json['reason_id'],
      potongCuti: json['potong_cuti'],
      startDate: json['start_date'],
      startTime: json['start_time'],
      endDate: json['end_date'],
      endTime: json['end_time'],
      lamaCuti: json['lama_cuti'],
      tglBatal: json['tgl_batal'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      jamKembali: json['jam_kembali'],
      photo1: json['photo_1'],
      photo2: json['photo_2'],
      photo3: json['photo_3'],
      keterangan: json['keterangan'],
      status: json['status'],
      statusApproval: json['status_approval'],
      statusKembali: json['status_kembali'],
      statusBatal: json['status_batal'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      reasonName: json['reason_name'],
      reasonTypeName: json['reason_type_name'],
      userApproval: json['user_approval'],
      descApproval: json['desc_approval'],
    );
  }
}
