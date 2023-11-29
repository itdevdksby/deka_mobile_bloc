// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@Entity(tableName: 'master_reason', primaryKeys: ['code'])
class MasterReasonEntity extends Equatable {
  String? code;
  String? name;
  int? type;
  String? keterangan;
  String? potong_cuti;
  int? status = 1;
  int? statusKirim = 0;
  String? createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String? updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  MasterReasonEntity({
    this.code,
    this.name,
    this.type,
    this.keterangan,
    this.potong_cuti,
    this.status,
    this.statusKirim,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      code,
      name,
      type,
      keterangan,
      potong_cuti,
      status,
      statusKirim,
      createdAt,
      updatedAt,
    ];
  }
}
