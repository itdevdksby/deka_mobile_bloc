import 'package:floor/floor.dart';

import 'pengaturan_autocode_android.dart';

@dao
abstract class PengaturanAutocodeAndroidDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEntity(PengaturanAutocodeAndroidEntity model);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEntity(PengaturanAutocodeAndroidEntity model);

  @delete
  Future<void> deleteEntity(PengaturanAutocodeAndroidEntity model);

  @Query('DELETE FROM pengaturan_autocode_android')
  Future<void> deleteAll();

  @Query('SELECT * FROM pengaturan_autocode_android')
  Future<List<PengaturanAutocodeAndroidEntity>> getPengaturanAutocodeAndroid();

  @Query('SELECT * FROM pengaturan_autocode_android WHERE code = ?')
  Future<List<PengaturanAutocodeAndroidEntity>> getPengaturanAutocodeAndroidOne(
      String code);

  @Query('SELECT * FROM pengaturan_autocode_android WHERE code LIKE ?')
  Future<List<PengaturanAutocodeAndroidEntity>>
      getPengaturanAutocodeAndroidByCode(String code);
}
