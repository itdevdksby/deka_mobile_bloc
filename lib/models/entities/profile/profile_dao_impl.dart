import 'dart:async';

import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'profile.dart';
import 'profile_dao.dart';

class ProfileDaoImpl extends ProfileDao {
  ProfileDaoImpl(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _insertionAdapter = InsertionAdapter(
            database,
            'profile',
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'nik': item.nik,
                  'username': item.username,
                  'password': item.password,
                  'typeuserCode': item.typeuserCode,
                  'typeuserName': item.typeuserName,
                  'code': item.code,
                  'name': item.name,
                  'address': item.address,
                  'tempatLahir': item.tempatLahir,
                  'tglLahir': item.tglLahir,
                  'tglMasuk': item.tglMasuk,
                  'email': item.email,
                  'phone1': item.phone1,
                  'phone2': item.phone2,
                  'photo': item.photo,
                  'photoKtp': item.photoKtp,
                  'noKtp': item.noKtp,
                  'typeuserId': item.typeuserId,
                  'divisiCode': item.divisiCode,
                  'jabatanCode': item.jabatanCode,
                  'deviceId': item.deviceId,
                  'deviceBrand': item.deviceBrand,
                  'deviceType': item.deviceType,
                  'firebaseId': item.firebaseId,
                  'costCenterCode': item.costCenterCode,
                  'lokasi': item.lokasi,
                  'organizationLevel': item.organizationLevel,
                  'status': item.status,
                  'statusKirim': item.statusKirim,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                }),
        _updateAdapter = UpdateAdapter(
            database,
            'profile',
            ['userId'],
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'nik': item.nik,
                  'username': item.username,
                  'password': item.password,
                  'typeuserCode': item.typeuserCode,
                  'typeuserName': item.typeuserName,
                  'code': item.code,
                  'name': item.name,
                  'address': item.address,
                  'tempatLahir': item.tempatLahir,
                  'tglLahir': item.tglLahir,
                  'tglMasuk': item.tglMasuk,
                  'email': item.email,
                  'phone1': item.phone1,
                  'phone2': item.phone2,
                  'photo': item.photo,
                  'photoKtp': item.photoKtp,
                  'noKtp': item.noKtp,
                  'typeuserId': item.typeuserId,
                  'divisiCode': item.divisiCode,
                  'jabatanCode': item.jabatanCode,
                  'deviceId': item.deviceId,
                  'deviceBrand': item.deviceBrand,
                  'deviceType': item.deviceType,
                  'firebaseId': item.firebaseId,
                  'costCenterCode': item.costCenterCode,
                  'lokasi': item.lokasi,
                  'organizationLevel': item.organizationLevel,
                  'status': item.status,
                  'statusKirim': item.statusKirim,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                }),
        _deletionAdapter = DeletionAdapter(
            database,
            'profile',
            ['userId'],
            (ProfileEntity item) => <String, Object?>{
                  'userId': item.userId,
                  'nik': item.nik,
                  'username': item.username,
                  'password': item.password,
                  'typeuserCode': item.typeuserCode,
                  'typeuserName': item.typeuserName,
                  'code': item.code,
                  'name': item.name,
                  'address': item.address,
                  'tempatLahir': item.tempatLahir,
                  'tglLahir': item.tglLahir,
                  'tglMasuk': item.tglMasuk,
                  'email': item.email,
                  'phone1': item.phone1,
                  'phone2': item.phone2,
                  'photo': item.photo,
                  'photoKtp': item.photoKtp,
                  'noKtp': item.noKtp,
                  'typeuserId': item.typeuserId,
                  'divisiCode': item.divisiCode,
                  'jabatanCode': item.jabatanCode,
                  'deviceId': item.deviceId,
                  'deviceBrand': item.deviceBrand,
                  'deviceType': item.deviceType,
                  'firebaseId': item.firebaseId,
                  'costCenterCode': item.costCenterCode,
                  'lokasi': item.lokasi,
                  'organizationLevel': item.organizationLevel,
                  'status': item.status,
                  'statusKirim': item.statusKirim,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProfileEntity> _insertionAdapter;

  final UpdateAdapter<ProfileEntity> _updateAdapter;

  final DeletionAdapter<ProfileEntity> _deletionAdapter;

  @override
  Future<void> insertEntity(ProfileEntity model) async {
    model.status = 1;
    model.statusKirim = 0;
    model.createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _insertionAdapter.insert(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateEntity(ProfileEntity model) async {
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _updateAdapter.update(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteEntity(ProfileEntity model) async {
    await _deletionAdapter.delete(model);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM profile');
  }

  @override
  Future<List<ProfileEntity>> getProfile() async {
    return _queryAdapter.queryList('SELECT * FROM profile',
        mapper: (Map<String, Object?> row) => _mapper(row));
  }

  ProfileEntity _mapper(Map<String, Object?> row) {
    return ProfileEntity(
      userId: row['userId'] as String?,
      nik: row['nik'] as String?,
      username: row['username'] as String?,
      password: row['password'] as String?,
      typeuserCode: row['typeuserCode'] as String?,
      typeuserName: row['typeuserName'] as String?,
      code: row['code'] as String?,
      name: row['name'] as String?,
      address: row['address'] as String?,
      tempatLahir: row['tempatLahir'] as String?,
      tglLahir: row['tglLahir'] as String?,
      tglMasuk: row['tglMasuk'] as String?,
      email: row['email'] as String?,
      phone1: row['phone1'] as String?,
      phone2: row['phone2'] as String?,
      photo: row['photo'] as String?,
      photoKtp: row['photoKtp'] as String?,
      noKtp: row['noKtp'] as String?,
      typeuserId: row['typeuserId'] as String?,
      divisiCode: row['divisiCode'] as String?,
      jabatanCode: row['jabatanCode'] as String?,
      deviceId: row['deviceId'] as String?,
      deviceBrand: row['deviceBrand'] as String?,
      deviceType: row['deviceType'] as String?,
      firebaseId: row['firebaseId'] as String?,
      costCenterCode: row['costCenterCode'] as String?,
      lokasi: row['lokasi'] as String?,
      organizationLevel: row['organizationLevel'] as String?,
      status: row['status'] as int?,
      statusKirim: row['statusKirim'] as int?,
      createdAt: row['createdAt'] as String?,
      updatedAt: row['updatedAt'] as String?,
    );
  }
}
