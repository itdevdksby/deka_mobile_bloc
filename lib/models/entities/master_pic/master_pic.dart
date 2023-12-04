// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@Entity(tableName: 'master_pic', primaryKeys: ['id'])
class MasterPicEntity extends Equatable {
  int? id;
  String? name;
  String? whatsapp;
  int? status = 1;
  int? statusKirim = 0;
  String? createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String? updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  MasterPicEntity({
    this.id,
    this.name,
    this.whatsapp,
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
      whatsapp,
      status,
      statusKirim,
      createdAt,
      updatedAt,
    ];
  }
}
