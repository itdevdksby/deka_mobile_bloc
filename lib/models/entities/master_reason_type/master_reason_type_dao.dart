import 'package:floor/floor.dart';

import 'master_reason_type.dart';

@dao
abstract class MasterReasonTypeDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEntity(MasterReasonTypeEntity model);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEntity(MasterReasonTypeEntity model);

  @delete
  Future<void> deleteEntity(MasterReasonTypeEntity model);

  @Query('DELETE FROM master_reason_type ')
  Future<void> deleteAll();

  @Query('SELECT * FROM master_reason_type  WHERE status = 1 ORDER BY name ASC')
  Future<List<MasterReasonTypeEntity>> getMasterReasonType();

  @Query(
      'SELECT * FROM master_reason_type WHERE status = 1 AND id = ? ORDER BY name ASC')
  Future<List<MasterReasonTypeEntity>> getMasterReasonTypeOne(int id);
}
