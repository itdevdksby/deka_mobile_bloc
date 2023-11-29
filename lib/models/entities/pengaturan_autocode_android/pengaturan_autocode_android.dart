// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@Entity(tableName: 'pengaturan_autocode_android', primaryKeys: ['code'])
class PengaturanAutocodeAndroidEntity extends Equatable {
  String? code;
  String? value;
  String? count;
  int? status = 1;
  int? statusKirim = 0;
  String? createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String? updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  PengaturanAutocodeAndroidEntity({
    this.code,
    this.value,
    this.count,
    this.status,
    this.statusKirim,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      code,
      value,
      count,
      status,
      statusKirim,
      createdAt,
      updatedAt,
    ];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["value"] = value;
    data["count"] = count;
    data["status"] = status;
    data["statusKirim"] = statusKirim;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    return data;
  }
}
