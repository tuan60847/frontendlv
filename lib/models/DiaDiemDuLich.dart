

class DiaDiemDuLich{
  final int MaDDDL ;
  final String TenDiaDiemDuLich;
  late String DiaChi;
  final String MoTa;
  final String GiaTien;
  late int MaTP;
  late String ThoiGianHoatDong;

  DiaDiemDuLich({required this.MaDDDL,required this.TenDiaDiemDuLich,required this.DiaChi,required this.MoTa,
   required this.MaTP, this.GiaTien="Free Ticked" , this.ThoiGianHoatDong="Anything"});

  Map<String, dynamic> toJson() {
    return {
      'MaDDDL': MaDDDL,
      'TenDiaDiemDuLich': TenDiaDiemDuLich,
      'DiaChi':DiaChi,
      'MoTa':MoTa,
      'GiaTien':GiaTien,
      'MaTP':MaTP,
      'ThoiGianHoatDong':ThoiGianHoatDong,
    };
  }





  factory DiaDiemDuLich.fromJson(Map<String, dynamic> json){
    return DiaDiemDuLich(
      MaDDDL: json["MaDDDL"],
      TenDiaDiemDuLich: json["TenDiaDiemDuLich"],
      DiaChi:json["DiaChi"],
      MoTa:json["MoTa"],
      GiaTien:json["GiaTien"],
      MaTP:json["MaTP"],
      ThoiGianHoatDong:json["ThoiGianHoatDong"],
    );

  }
}