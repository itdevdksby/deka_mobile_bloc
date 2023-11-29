import '../entities/profile/profile.dart';
import '../response/login_model.dart';

ProfileEntity ProfileMapper(LoginModel model) {
  return ProfileEntity(
    userId : model.userId.toString(),
    nik : model.nik,
    username : model.username,
    password : model.password,
    typeuserCode : model.typeuserId,
    typeuserName : model.typeuserId,
    code : model.code,
    name : model.name,
    address : model.address,
    tempatLahir : model.tempatLahir,
    tglLahir : model.tglLahir,
    tglMasuk : model.tglMasuk,
    email : model.email,
    phone1 : model.phone1,
    phone2 : model.phone2,
    photo : model.photo,
    photoKtp : model.photoKtp,
    noKtp : model.noKtp,
    typeuserId : model.typeuserId,
    divisiCode : model.divisiCode,
    jabatanCode : model.jabatanCode,
    deviceId : model.deviceId,
    deviceBrand : model.deviceBrand,
    deviceType : model.deviceType,
    firebaseId : model.firebaseId,
    costCenterCode : model.costCenterCode,
    lokasi : model.lokasi.toString(),
    organizationLevel : model.organizationLevel,
  );
}