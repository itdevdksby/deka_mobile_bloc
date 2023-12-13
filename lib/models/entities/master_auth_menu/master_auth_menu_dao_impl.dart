
import 'dart:async';

import 'package:deka_mobile/models/entities/master_auth_menu/master_auth_menu.dart';
import 'package:deka_mobile/models/entities/master_auth_menu/master_auth_menu_dao.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


class MasterAuthMenuDaoImpl extends MasterAuthMenuDao {
  MasterAuthMenuDaoImpl(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _insertionAdapter = InsertionAdapter(
            database,
            'master_auth_menu',
            (MasterAuthMenuEntity item) => <String, Object?>{
              'id': item.id,
              'slug': item.slug,
              'name': item.name,
              'is_read': item.is_read,
              'is_update': item.is_update,
              'is_create': item.is_create,
              'is_delete': item.is_delete,
              'is_approval': item.is_approval,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            }),
        _updateAdapter = UpdateAdapter(
            database,
            'master_auth_menu',
            ['id'],
            (MasterAuthMenuEntity item) => <String, Object?>{
              'id': item.id,
              'slug': item.slug,
              'name': item.name,
              'is_read': item.is_read,
              'is_update': item.is_update,
              'is_create': item.is_create,
              'is_delete': item.is_delete,
              'is_approval': item.is_approval,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            }),
        _deletionAdapter = DeletionAdapter(
            database,
            'master_auth_menu',
            ['id'],
            (MasterAuthMenuEntity item) => <String, Object?>{
              'id': item.id,
              'slug': item.slug,
              'name': item.name,
              'is_read': item.is_read,
              'is_update': item.is_update,
              'is_create': item.is_create,
              'is_delete': item.is_delete,
              'is_approval': item.is_approval,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MasterAuthMenuEntity> _insertionAdapter;

  final UpdateAdapter<MasterAuthMenuEntity> _updateAdapter;

  final DeletionAdapter<MasterAuthMenuEntity> _deletionAdapter;

  @override
  Future<void> insertEntity(MasterAuthMenuEntity model) async {
    model.status = 1;
    model.statusKirim = 0;
    model.createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _insertionAdapter.insert(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateEntity(MasterAuthMenuEntity model) async {
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _updateAdapter.update(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteEntity(MasterAuthMenuEntity model) async {
    await _deletionAdapter.delete(model);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM master_auth_menu');
  }

  @override
  Future<List<MasterAuthMenuEntity>> getMasterAuthMenu() {
    return _queryAdapter.queryList(
        'SELECT * FROM master_auth_menu WHERE status = 1 ORDER BY name ASC',
        mapper: (Map<String, Object?> row) => _mapper(row));
  }

  @override
  Future<List<MasterAuthMenuEntity>> getMasterAuthMenuOne(int id) {
    return _queryAdapter.queryList(
        'SELECT * FROM master_auth_menu WHERE status = 1 AND id = ? ORDER BY name ASC',
        arguments: [id],
        mapper: (Map<String, Object?> row) => _mapper(row));
  }

  MasterAuthMenuEntity _mapper(Map<String, Object?> row) {
    return MasterAuthMenuEntity(
      id: row['id'] as int?,
      slug: row['slug'] as String?,
      name: row['name'] as String?,
      is_read: row['is_read'] as int?,
      is_update: row['is_update'] as int?,
      is_create: row['is_create'] as int?,
      is_delete: row['is_delete'] as int?,
      is_approval: row['is_approval'] as int?,
      status: row['status'] as int?,
      statusKirim: row['statusKirim'] as int?,
      createdAt: row['createdAt'] as String?,
      updatedAt: row['updatedAt'] as String?,
    );
  }
}
