import 'package:floor/floor.dart';

import 'master_auth_menu.dart';

@dao
abstract class MasterAuthMenuDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEntity(MasterAuthMenuEntity model);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEntity(MasterAuthMenuEntity model);

  @delete
  Future<void> deleteEntity(MasterAuthMenuEntity model);

  @Query('DELETE FROM master_auth_menu')
  Future<void> deleteAll();

  @Query('SELECT * FROM master_auth_menu WHERE status = 1 ORDER BY name ASC')
  Future<List<MasterAuthMenuEntity>> getMasterAuthMenu();

  @Query('SELECT * FROM master_auth_menu WHERE status = 1 AND id = ? ORDER BY name ASC')
  Future<List<MasterAuthMenuEntity>> getMasterAuthMenuOne(int id);

}