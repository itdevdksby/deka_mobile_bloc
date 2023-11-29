import 'dart:async';

import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'master_reason_type.dart';
import 'master_reason_type_dao.dart';

class MasterReasonTypeDaoImpl extends MasterReasonTypeDao {
  MasterReasonTypeDaoImpl(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _insertionAdapter = InsertionAdapter(
            database,
            'master_reason_type',
                (MasterReasonTypeEntity item) => <String, Object?>{
              'id' : item.id,
              'name' : item.name,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            }),
        _updateAdapter = UpdateAdapter(
            database,
            'master_reason_type',
            ['id'],
                (MasterReasonTypeEntity item) => <String, Object?>{
              'id' : item.id,
              'name' : item.name,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            }),
        _deletionAdapter = DeletionAdapter(
            database,
            'master_reason_type',
            ['id'],
                (MasterReasonTypeEntity item) => <String, Object?>{
              'id' : item.id,
              'name' : item.name,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MasterReasonTypeEntity> _insertionAdapter;

  final UpdateAdapter<MasterReasonTypeEntity> _updateAdapter;

  final DeletionAdapter<MasterReasonTypeEntity> _deletionAdapter;

  @override
  Future<void> deleteEntity(MasterReasonTypeEntity model) async {
    await _deletionAdapter.delete(model);
  }

  @override
  Future<void> insertEntity(MasterReasonTypeEntity model) async {
    model.status = 1;
    model.statusKirim = 0;
    model.createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _insertionAdapter.insert(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateEntity(MasterReasonTypeEntity model) async {
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _updateAdapter.update(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM master_reason_type');
  }

  @override
  Future<List<MasterReasonTypeEntity>> getMasterReasonType() {
    return _queryAdapter.queryList('SELECT * FROM master_reason_type WHERE status = 1 ORDER BY name ASC',
        mapper: (Map<String, Object?> row) => _mapper(row)
    );
  }

  @override
  Future<List<MasterReasonTypeEntity>> getMasterReasonTypeOne(int id) {
    return _queryAdapter.queryList('SELECT * FROM master_reason_type WHERE status = 1 AND id = ? ORDER BY name ASC',
        arguments: [id],
        mapper: (Map<String, Object?> row) => _mapper(row)
    );
  }

  MasterReasonTypeEntity _mapper(Map<String, Object?> row) {
    return MasterReasonTypeEntity(
      id: row['id'] as int?,
      name: row['name'] as String?,
      status: row['status'] as int?,
      statusKirim: row['statusKirim'] as int?,
      createdAt: row['createdAt'] as String?,
      updatedAt: row['updatedAt'] as String?,
    );
  }
}