
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'master_pic.dart';
import 'master_pic_dao.dart';

class MasterPicDaoImpl extends MasterPicDao {
  MasterPicDaoImpl(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _insertionAdapter = InsertionAdapter(
            database,
            'master_pic',
            (MasterPicEntity item) => <String, Object?>{
              'id': item.id,
              'name': item.name,
              'whatsapp': item.whatsapp,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            }),
        _updateAdapter = UpdateAdapter(
            database,
            'master_pic',
            ['id'],
            (MasterPicEntity item) => <String, Object?>{
              'id': item.id,
              'name': item.name,
              'whatsapp': item.whatsapp,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            }),
        _deletionAdapter = DeletionAdapter(
            database,
            'master_pic',
            ['id'],
            (MasterPicEntity item) => <String, Object?>{
              'id': item.id,
              'name': item.name,
              'whatsapp': item.whatsapp,
              'status': item.status,
              'statusKirim': item.statusKirim,
              'createdAt': item.createdAt,
              'updatedAt': item.updatedAt,
            });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MasterPicEntity> _insertionAdapter;

  final UpdateAdapter<MasterPicEntity> _updateAdapter;

  final DeletionAdapter<MasterPicEntity> _deletionAdapter;

  @override
  Future<void> insertEntity(MasterPicEntity model) async {
    model.status = 1;
    model.statusKirim = 0;
    model.createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _insertionAdapter.insert(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateEntity(MasterPicEntity model) async {
    model.updatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _updateAdapter.update(model, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteEntity(MasterPicEntity model) async {
    await _deletionAdapter.delete(model);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM master_pic');
  }

  @override
  Future<List<MasterPicEntity>> getMasterPic() {
    return _queryAdapter.queryList(
        'SELECT * FROM master_pic WHERE status = 1 ORDER BY name ASC',
        mapper: (Map<String, Object?> row) => _mapper(row));
  }

  @override
  Future<List<MasterPicEntity>> getMasterPicOne(int id) {
    return _queryAdapter.queryList(
        'SELECT * FROM master_pic WHERE status = 1 AND id = ? ORDER BY name ASC',
        arguments: [id],
        mapper: (Map<String, Object?> row) => _mapper(row));
  }

  MasterPicEntity _mapper(Map<String, Object?> row) {
    return MasterPicEntity(
      id: row['id'] as int?,
      name: row['name'] as String?,
      whatsapp: row['whatsapp'] as String?,
      status: row['status'] as int?,
      statusKirim: row['statusKirim'] as int?,
      createdAt: row['createdAt'] as String?,
      updatedAt: row['updatedAt'] as String?,
    );
  }
}
