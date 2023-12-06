import 'dart:async';

import 'package:deka_mobile/models/entities/master_reason_hc/master_reason_hc.dart';
import 'package:deka_mobile/models/entities/master_reason_hc/master_reason_hc_dao.dart';
import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class MasterReasonHcDaoImpl extends MasterReasonHcDao {
  MasterReasonHcDaoImpl(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _insertionAdapter = InsertionAdapter(
            database,
            'master_reason_hc',
                (MasterReasonHcEntity item) => <String, Object?>{
              'id' : item.id,
              'name' : item.name,
              'type' : item.type,
              'keterangan' : item.keterangan,
              'potongCuti' : item.potongCuti,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            }),
        _updateAdapter = UpdateAdapter(
            database,
            'master_reason_hc',
            ['id'],
                (MasterReasonHcEntity item) => <String, Object?>{
              'id' : item.id,
              'name' : item.name,
              'type' : item.type,
              'keterangan' : item.keterangan,
              'potongCuti' : item.potongCuti,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            }),
        _deletionAdapter = DeletionAdapter(
            database,
            'master_reason_hc',
            ['id'],
                (MasterReasonHcEntity item) => <String, Object?>{
              'id' : item.id,
              'name' : item.name,
              'type' : item.type,
              'keterangan' : item.keterangan,
              'potongCuti' : item.potongCuti,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MasterReasonHcEntity> _insertionAdapter;

  final UpdateAdapter<MasterReasonHcEntity> _updateAdapter;

  final DeletionAdapter<MasterReasonHcEntity> _deletionAdapter;

  @override
  Future<void> deleteEntity(MasterReasonHcEntity model) async {
    await _deletionAdapter.delete(model);
  }

  @override
  Future<void> insertEntity(MasterReasonHcEntity model) async {
    model.status = 1;
    model.statusKirim = 0;
    model.createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _insertionAdapter.insert(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateEntity(MasterReasonHcEntity model) async {
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _updateAdapter.update(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM master_reason_hc');
  }

  @override
  Future<List<MasterReasonHcEntity>> getMasterReasonHc() {
    return _queryAdapter.queryList('SELECT * FROM master_reason_hc WHERE status = 1 ORDER BY name ASC',
        mapper: (Map<String, Object?> row) => _mapper(row)
    );
  }

  @override
  Future<List<MasterReasonHcEntity>> getMasterReasonHcByType(int type) {
    return _queryAdapter.queryList('SELECT * FROM master_reason_hc WHERE status = 1 AND type = ? ORDER BY name ASC',
        arguments: [type],
        mapper: (Map<String, Object?> row) => _mapper(row)
    );
  }

  MasterReasonHcEntity _mapper(Map<String, Object?> row) {
    return MasterReasonHcEntity(
      id: row['id'] as int?,
      name: row['name'] as String?,
      type: row['type'] as int?,
      keterangan: row['keterangan'] as String?,
      potongCuti: row['potongCuti'] as String?,
      status: row['status'] as int?,
      statusKirim: row['statusKirim'] as int?,
      createdAt: row['createdAt'] as String?,
      updatedAt: row['updatedAt'] as String?,
    );
  }
}