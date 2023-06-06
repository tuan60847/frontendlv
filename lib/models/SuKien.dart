class SuKien {
  final int maSuKien;
  final String TenSuKien;
  late String Mota;
  final String NgayBatDau;
  final String NgayKetThuc;
  late String MADDL;

  SuKien(
      {required this.maSuKien,
        required this.TenSuKien,
        required this.NgayBatDau,
        this.Mota="",
        this.NgayKetThuc="",
        required this.MADDL});

  Map<String, dynamic> toJson() {
    return {
      'maSuKien': maSuKien,
      'TenSuKien': TenSuKien,
      'NgayBatDau': NgayBatDau,
      'Mota': Mota,
      'NgayKetThuc': NgayKetThuc,
      'MADDL': MADDL,

    };
  }

  factory SuKien.fromJson(Map<String, dynamic> json) {
    return SuKien(
      maSuKien: json["maSuKien"],
      TenSuKien: json["TenSuKien"],
      NgayBatDau: json["NgayBatDau"],
      Mota: json["Mota"],
      NgayKetThuc: json["NgayKetThuc"],
      MADDL: json["MADDL"],

    );
  }
}
