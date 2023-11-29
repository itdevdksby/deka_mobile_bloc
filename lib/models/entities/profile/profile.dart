// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@Entity(tableName: 'profile', primaryKeys: ['userId'])
class ProfileEntity extends Equatable {
  String? userId;
  String? nik;
  String? username;
  String? password;
  String? typeuserCode;
  String? typeuserName;
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
  String? lokasi;
  String? organizationLevel;
  int? status = 1;
  int? statusKirim = 0;
  String? createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String? updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  ProfileEntity({
    this.username,
    this.password,
    this.typeuserCode,
    this.typeuserName,
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
    this.organizationLevel,
    this.status,
    this.statusKirim,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      username,
      password,
      typeuserCode,
      typeuserName,
      userId,
      nik,
      code,
      name,
      address,
      tempatLahir,
      tglLahir,
      tglMasuk,
      email,
      phone1,
      phone2,
      photo,
      photoKtp,
      noKtp,
      typeuserId,
      divisiCode,
      jabatanCode,
      deviceId,
      deviceBrand,
      deviceType,
      firebaseId,
      costCenterCode,
      lokasi,
      organizationLevel,
      status,
      statusKirim,
      createdAt,
      updatedAt,
    ];
  }
}
