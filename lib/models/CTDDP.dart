class CTDDP{
  int UIDCTDDP;
  String MaDDP;
  int UIDLoaiPhong;
  int SoNgayO;
  int soLuongPhong;
  int Tien;

  CTDDP(
      {required this.UIDCTDDP,
        required this.MaDDP,
        required this.UIDLoaiPhong,
        required this.SoNgayO,
        required this.soLuongPhong,
        required this.Tien});

  factory CTDDP.fromJson(Map<String, dynamic> json) {
    return CTDDP(
      UIDCTDDP: json["UIDCTDDP"],
      MaDDP: json["MaDDP"],
      UIDLoaiPhong: json["UIDLoaiPhong"],
      SoNgayO: json["SoNgayO"],
      soLuongPhong: json["soLuongPhong"],
      Tien: json["Tien"],

    );
  }
}