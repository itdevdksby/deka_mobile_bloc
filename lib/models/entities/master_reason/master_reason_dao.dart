import 'package:floor/floor.dart';

import 'master_reason.dart';

@dao
abstract class MasterReasonDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEntity(MasterReasonEntity model);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEntity(MasterReasonEntity model);

  @delete
  Future<void> deleteEntity(MasterReasonEntity model);

  @Query('DELETE FROM master_reason')
  Future<void> deleteAll();

  @Query('SELECT * FROM master_reason WHERE status = 1 ORDER BY name ASC')
  Future<List<MasterReasonEntity>> getMasterReason();

  @Query('SELECT * FROM master_reason WHERE status = 1 AND code = ? ORDER BY name ASC')
  Future<List<MasterReasonEntity>> getMasterReasonOne(String code);

  @Query('SELECT * FROM master_reason WHERE status = 1 AND type = ? ORDER BY name ASC')
  Future<List<MasterReasonEntity>> getMasterReasonByType(int type);
}