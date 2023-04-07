class KhachSan {
  final String UIDKS;
  final String TenKS;
  final String DiaChi;
  final String SDT;
  final bool isActive;

  KhachSan({required this.UIDKS,required this.TenKS,required this.DiaChi,required this.SDT, this.isActive=false});


  Map<String, dynamic> toJson() {
    return {
      'UIDKS': UIDKS,
      'TenKS': TenKS,
      'DiaChi':DiaChi,
      'SDT':SDT,
      'isActive':isActive,
    };
  }

  factory KhachSan.fromJson(Map<String, dynamic> json){
    return KhachSan(
      UIDKS: json["UIDKS"],
      TenKS: json["TenKS"],
      DiaChi:json["DiaChi"],
      SDT:json["SDT"],
      isActive:json["isActive"],

    );

  }
}