import 'package:floor/floor.dart';

import 'master_pic.dart';

@dao
abstract class MasterPicDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEntity(MasterPicEntity model);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEntity(MasterPicEntity model);

  @delete
  Future<void> deleteEntity(MasterPicEntity model);

  @Query('DELETE FROM master_reason')
  Future<void> deleteAll();

  @Query('SELECT * FROM master_pic WHERE status = 1 ORDER BY name ASC')
  Future<List<MasterPicEntity>> getMasterPic();

  @Query('SELECT * FROM master_pic WHERE status = 1 AND id = ? ORDER BY name ASC')
  Future<List<MasterPicEntity>> getMasterPicOne(int id);

}