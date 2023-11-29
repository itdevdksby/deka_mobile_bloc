import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/entities/master_reason/master_reason.dart';
import '../models/entities/master_reason/master_reason_dao.dart';
import '../models/entities/master_reason/master_reason_dao_impl.dart';
import '../models/entities/master_reason_type/master_reason_type.dart';
import '../models/entities/master_reason_type/master_reason_type_dao.dart';
import '../models/entities/master_reason_type/master_reason_type_dao_impl.dart';
import '../models/entities/pengaturan_autocode_android/pengaturan_autocode_android.dart';
import '../models/entities/pengaturan_autocode_android/pengaturan_autocode_android_dao.dart';
import '../models/entities/pengaturan_autocode_android/pengaturan_autocode_android_dao_impl.dart';
import '../models/entities/profile/profile.dart';
import '../models/entities/profile/profile_dao.dart';
import '../models/entities/profile/profile_dao_impl.dart';
import 'migration_scripts.dart';

part 'database_config_impl.dart';

@Database(version: 8, entities: [
  ProfileEntity,
  PengaturanAutocodeAndroidEntity,
  MasterReasonEntity,
  MasterReasonTypeEntity
])
abstract class DatabaseConfig extends FloorDatabase {
  ProfileDao get profileDao;
  PengaturanAutocodeAndroidDao get pengaturanAutocodeAndroidDao;
  MasterReasonDao get masterReasonDao;
  MasterReasonTypeDao get masterReasonTypeDao;
}
