import 'package:equatable/equatable.dart';

class RekapIzinEntity extends Equatable {
  final String ? code;
  final String ? jpayrollId;
  final String ? name;
  final String ? nik;
  final String ? costCenterCode;
  final String ? reasonType;
  final String ? reasonId;
  final String ? potongCuti;
  final String ? startDate;
  final String ? startTime;
  final String ? endDate;
  final String ? endTime;
  final String ? lamaCuti;
  final String ? tglBatal;
  final String ? latitude;
  final String ? longitude;
  final String ? jamKembali;
  final String ? photo1;
  final String ? photo2;
  final String ? photo3;
  final String ? keterangan;
  final String ? status;
  final String ? statusApproval;
  final String ? statusKembali;
  final String ? statusBatal;
  final String ? createdAt;
  final String ? updatedAt;
  final String ? createdBy;
  final String ? updatedBy;
  final String ? reasonName;
  final String ? reasonTypeName;
  final String ? userApproval;
  final String ? descApproval;

  RekapIzinEntity({
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

  @override
  List<Object?> get props {
    return [
      code,
      jpayrollId,
      name,
      nik,
      costCenterCode,
      reasonType,
      reasonId,
      potongCuti,
      startDate,
      startTime,
      endDate,
      endTime,
      lamaCuti,
      tglBatal,
      latitude,
      longitude,
      jamKembali,
      photo1,
      photo2,
      photo3,
      keterangan,
      status,
      statusApproval,
      statusKembali,
      statusBatal,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
      reasonName,
      reasonTypeName,
      userApproval,
      descApproval,
    ];
  }
}