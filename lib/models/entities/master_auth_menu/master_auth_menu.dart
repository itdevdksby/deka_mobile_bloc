// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@Entity(tableName: 'master_auth_menu', primaryKeys: ['id'])
class MasterAuthMenuEntity extends Equatable {
  int? id;
  String? slug;
  String? name;
  int? is_read;
  int? is_update;
  int? is_create;
  int? is_delete;
  int? is_approval;
  int? status = 1;
  int? statusKirim = 0;
  String? createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String? updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  MasterAuthMenuEntity({
    this.id,
    this.slug,
    this.name,
    this.is_read,
    this.is_update,
    this.is_create,
    this.is_delete,
    this.is_approval,
    this.status,
    this.statusKirim,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      slug,
      name,
      is_read,
      is_update,
      is_create,
      is_delete,
      is_approval,
      status,
      statusKirim,
      createdAt,
      updatedAt,
    ];
  }
}
