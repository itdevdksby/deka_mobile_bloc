// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@Entity(tableName: 'master_reason_type', primaryKeys: ['id'])
class MasterReasonTypeEntity extends Equatable {
  int? id;
  String? name;
  int? status = 1;
  int? statusKirim = 0;
  String? createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String? updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  MasterReasonTypeEntity({
    this.id,
    this.name,
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
      status,
      statusKirim,
      createdAt,
      updatedAt,
    ];
  }
}
