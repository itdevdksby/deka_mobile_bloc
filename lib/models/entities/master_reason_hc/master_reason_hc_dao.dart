import 'package:deka_mobile/models/entities/master_reason_hc/master_reason_hc.dart';
import 'package:floor/floor.dart';

@dao
abstract class MasterReasonHcDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEntity(MasterReasonHcEntity model);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEntity(MasterReasonHcEntity model);

  @delete
  Future<void> deleteEntity(MasterReasonHcEntity model);

  @Query('DELETE FROM master_reason_hc ')
  Future<void> deleteAll();

  @Query('SELECT * FROM master_reason_hc  WHERE status = 1 ORDER BY name ASC')
  Future<List<MasterReasonHcEntity>> getMasterReasonHc();

  @Query(
      'SELECT * FROM master_reason_hc WHERE status = 1 AND type = ? ORDER BY name ASC')
  Future<List<MasterReasonHcEntity>> getMasterReasonHcByType(int type);
}
