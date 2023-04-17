class DonDatPhong {
  String UIDDatPhong;
  String EmailKH;
  String NgayDatPhong;
  int isChecked;
  int TienCoc;
  int tongtien;

  DonDatPhong(
      {required this.UIDDatPhong,
      required this.EmailKH,
      required this.NgayDatPhong,
      required this.isChecked,
        required this.TienCoc,
       this.tongtien=0});

  factory DonDatPhong.fromJson(Map<String, dynamic> json) {
    return DonDatPhong(
      UIDDatPhong: json["UIDDatPhong"],
      EmailKH: json["EmailKH"],
      NgayDatPhong: json["NgayDatPhong"],
      isChecked: json["isChecked"],
      TienCoc: json["TienCoc"],
      tongtien: json["tongtien"],

    );
  }
}

