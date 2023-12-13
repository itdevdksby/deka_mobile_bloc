import '../core/single_select/single_select_domain.dart';
import '../models/entities/pengaturan_autocode_android/pengaturan_autocode_android.dart';

const String BASE_URL =
    "https://appdk-trial.duakelinci.id:9393/api/webusagi/v2/hc/";
const int BASE_TIMEOUT = 60000 * 1; //1 MENIT
const String TYPE_APLIKASI = "hc";
const String NIK_EXAMPLE = '20101720';

const String varReset = "Reset Password";
const String varRegister = "Daftar User";
const String varDashboard = "Dashboard";
const String varRekapIzin = "Rekap Izin";
const String varGreeting = "Semoga Hari Anda Menyenangkan";
const String varGreetingLogin = "Silahkan login untuk melanjutkan";
const String varTotalAlpha = "Total Alpha";
const String varSisaCuti = "Sisa Cuti";
const String varTotalIzin = "Total Izin";
const String varIzinBelumDisetujui = "Izin Belum Disetujui";
const String varIzinDisetujui = "Izin Disetujui";
const String varIzinDitolak = "Izin Ditolak";
const String varUsername = "Username";
const String varPassword = "Password";

List<SingleSelectDomain> listLokasi = [
  SingleSelectDomain(codeOrId: "0", message: "Non Pati"),
  SingleSelectDomain(codeOrId: "1", message: "Pati"),
];

List<PengaturanAutocodeAndroidEntity> listPengaturanAutocode = [
  PengaturanAutocodeAndroidEntity(code: "last-sync-hc_reason", value: "0"),
  PengaturanAutocodeAndroidEntity(code: "last-sync-hc_reason_type", value: "0"),
  PengaturanAutocodeAndroidEntity(code: "last-sync-hc_data_pic", value: "0"),
  PengaturanAutocodeAndroidEntity(code: "last-sync-android_auth_menu", value: "0"),
  PengaturanAutocodeAndroidEntity(code: "hc-address", value: "0"),
  PengaturanAutocodeAndroidEntity(code: "hc-contact", value: "0"),
];

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}