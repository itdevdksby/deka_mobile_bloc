
class SyncDataMasterModel {
  List<HcReason>? hcReason;
  List<HcReasonType>? hcReasonType;
  List<HcDataPic>? hcDataPic;
  List<AndroidAuthMenu>? androidAuthMenu;
  List<HcAddress>? hcAddress;
  List<HcContact>? hcContact;

  SyncDataMasterModel({
    this.hcReason,
    this.hcReasonType,
    this.hcDataPic,
    this.androidAuthMenu,
    this.hcAddress,
    this.hcContact
  });


  factory SyncDataMasterModel.fromJson(dynamic json) {
    final response = SyncDataMasterModel();

    if (json['hc_reason'] != null) {
      response.hcReason = <HcReason>[];
      json['hc_reason'].forEach((v) {
        response.hcReason?.add(HcReason.fromJson(v));
      });
    }
    if (json['hc_reason_type'] != null) {
      response.hcReasonType = <HcReasonType>[];
      json['hc_reason_type'].forEach((v) {
        response.hcReasonType?.add(HcReasonType.fromJson(v));
      });
    }
    if (json['hc_data_pic'] != null) {
      response.hcDataPic = <HcDataPic>[];
      json['hc_data_pic'].forEach((v) {
        response.hcDataPic?.add(HcDataPic.fromJson(v));
      });
    }
    if (json['android_auth_menu'] != null) {
      response.androidAuthMenu = <AndroidAuthMenu>[];
      json['android_auth_menu'].forEach((v) {
        response.androidAuthMenu?.add(AndroidAuthMenu.fromJson(v));
      });
    }
    if (json['hc-address'] != null) {
      response.hcAddress = <HcAddress>[];
      json['hc-address'].forEach((v) {
        response.hcAddress?.add(HcAddress.fromJson(v));
      });
    }
    if (json['hc-contact'] != null) {
      response.hcContact = <HcContact>[];
      json['hc-contact'].forEach((v) {
        response.hcContact?.add(HcContact.fromJson(v));
      });
    }

    return response;
  }
}

class HcReason {
  String? code;
  String? name;
  String? idType;
  String? potongCuti;
  String? keterangan;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  HcReason({
    this.code,
    this.name,
    this.idType,
    this.potongCuti,
    this.keterangan,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy});

  factory HcReason.fromJson(Map<String, dynamic> json) {
    return HcReason(
      code: json['code'],
      name: json['name'],
      idType: json['id_type'],
      potongCuti: json['potong_cuti'],
      keterangan: json['keterangan'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }
}

class HcReasonType {
  String? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  HcReasonType({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy
  });

  factory HcReasonType.fromJson(Map<String, dynamic> json) {
    return HcReasonType(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }
}

class HcDataPic {
  String? code;
  String? name;
  String? phone;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  HcDataPic({
    this.code,
    this.name,
    this.phone,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt
  });

  factory HcDataPic.fromJson(Map<String, dynamic> json) {
    return HcDataPic(
      code: json['code'],
      name: json['name'],
      phone: json['phone'],
      status: json['status'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'],
    );
  }
}

class AndroidAuthMenu {
  String? userId;
  String? menuId;
  String? isRead;
  String? isUpdate;
  String? isCreate;
  String? isDelete;
  String? isApproval;
  String? createdAt;
  String? updatedAt;
  String? menuName;
  String? menuSlug;

  AndroidAuthMenu({
    this.userId,
    this.menuId,
    this.isRead,
    this.isUpdate,
    this.isCreate,
    this.isDelete,
    this.isApproval,
    this.createdAt,
    this.updatedAt,
    this.menuName,
    this.menuSlug
  });

  factory AndroidAuthMenu.fromJson(Map<String, dynamic> json) {
    return AndroidAuthMenu(
      userId: json['user_id'],
      menuId: json['menu_id'],
      isRead: json['is_read'],
      isUpdate: json['is_update'],
      isCreate: json['is_create'],
      isDelete: json['is_delete'],
      isApproval: json['is_approval'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      menuName: json['menu_name'],
      menuSlug: json['menu_slug'],
    );
  }
}

class HcAddress {
  String? slug;
  String? name;
  String? value;
  String? description;

  HcAddress({
    this.slug,
    this.name,
    this.value,
    this.description
  });

  factory HcAddress.fromJson(Map<String, dynamic> json) {
    return HcAddress(
      slug: json['slug'],
      name: json['name'],
      value: json['value'],
      description: json['description'],
    );
  }
}

class HcContact {
  String? slug;
  String? name;
  String? value;
  String? description;

  HcContact({
    this.slug,
    this.name,
    this.value,
    this.description
  });

  factory HcContact.fromJson(Map<String, dynamic> json) {
    return HcContact(
      slug: json['slug'],
      name: json['name'],
      value: json['value'],
      description: json['description'],
    );
  }
}