class KhachSan {
  final String UIDKS;
  final String TenKS;
  final String DiaChi;
  final String SDT;
  final int MaDDL;
  final bool isActive;
  final bool Buffet;
  final bool Wifi;

  KhachSan({required this.UIDKS,required this.TenKS,required this.DiaChi,required this.SDT,required this.MaDDL, this.isActive=false,this.Buffet=false,this.Wifi=false});


  Map<String, dynamic> toJson() {
    return {
      'UIDKS': UIDKS,
      'TenKS': TenKS,
      'DiaChi':DiaChi,
      'SDT':SDT,
      'isActive':isActive,
      'MaDDL':MaDDL,
      'Buffet':Buffet,
      'Wifi':Wifi,
    };
  }

  factory KhachSan.fromJson(Map<String, dynamic> json){
    return KhachSan(
      UIDKS: json["UIDKS"],
      TenKS: json["TenKS"],
      DiaChi:json["DiaChi"],
      SDT:json["SDT"],
      MaDDL: json["MaDDDL"],
      Buffet: json["Buffet"],
      Wifi: json["Wifi"],
      isActive:json["isActive"],

    );

  }
}