class Loaiphong {
  int UIDLoaiPhong;
  String TenLoaiPhong;
  int Gia;
  String UIDKS;
  String soGiuong;
  int soLuongPhong;
  int phongConLai;
  bool isMayLanh;

  Loaiphong({
    required this.UIDLoaiPhong,
    required this.TenLoaiPhong,
    required this.Gia,
    required this.UIDKS,
    required this.soGiuong,
    required this.soLuongPhong,
    required this.isMayLanh,
    this.phongConLai = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'UIDLoaiPhong': UIDLoaiPhong,
      'TenLoaiPhong': TenLoaiPhong,
      'Gia': Gia,
      'UIDKS': UIDKS,
      'soGiuong': soGiuong,
      'phongConLai': phongConLai,
      'isMayLanh': isMayLanh,
    };
  }

  factory Loaiphong.fromJson(Map<String, dynamic> json) {
    return Loaiphong(
      UIDLoaiPhong: json["UIDLoaiPhong"],
      TenLoaiPhong: json["TenLoaiPhong"],
      Gia: json["Gia"],
      UIDKS: json["UIDKS"],
      soGiuong: json["soGiuong"],
      soLuongPhong: json["soLuongPhong"],
      phongConLai: json["phongConLai"],
      isMayLanh: json["isMayLanh"],
    );
  }
}
