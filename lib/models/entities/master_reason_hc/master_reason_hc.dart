// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@Entity(tableName: 'master_reason_hc', primaryKeys: ['id'])
class MasterReasonHcEntity extends Equatable {
  int? id;
  String? name;
  int? type;
  String? keterangan;
  String? potongCuti;
  int? status = 1;
  int? statusKirim = 0;
  String? createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String? updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  MasterReasonHcEntity({
    this.id,
    this.name,
    this.type,
    this.keterangan,
    this.potongCuti,
    this.status,
    this.statusKirim,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      type,
      keterangan,
      potongCuti,
      status,
      statusKirim,
      createdAt,
      updatedAt,
    ];
  }
}
