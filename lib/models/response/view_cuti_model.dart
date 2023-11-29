
class ViewCutiModel {
  String? tahun;
  String? nik;
  String? name;
  String? jumlahCuti;
  String? jumlahAlpha;
  String? jumlahSisaCuti;
  String? totalWaiting;
  String? totalApproved;
  String? totalReject;
  String? totalIzin;

  ViewCutiModel({
    this.tahun,
    this.nik,
    this.name,
    this.jumlahCuti,
    this.jumlahAlpha,
    this.jumlahSisaCuti,
    this.totalWaiting,
    this.totalApproved,
    this.totalReject,
    this.totalIzin,
  });


  factory ViewCutiModel.fromJson(dynamic json) {
    return ViewCutiModel(
      tahun: json['tahun'],
      nik: json['nik'],
      name: json['name'],
      jumlahCuti: json['jumlah_cuti'],
      jumlahAlpha: json['jumlah_alpha'],
      jumlahSisaCuti: json['jumlah_sisa_cuti'],
      totalWaiting: json['total_waiting'],
      totalApproved: json['total_approved'],
      totalReject: json['total_reject'],
    );
  }
}