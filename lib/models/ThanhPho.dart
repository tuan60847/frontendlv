class ThanhPho{
  int MaTP;
  String  TenTP;
  String Mota;

  ThanhPho({required this.MaTP, required this.TenTP,this.Mota=""});

  Map<String, dynamic> toJson() {
    return {
      'MaTP': MaTP,
      'TenTP': TenTP,
      'mota':Mota
    };
  }

  factory ThanhPho.fromJson(Map<String, dynamic> json){
    return ThanhPho(
      MaTP: json["MaTP"],
      TenTP: json["TenTP"],
      Mota: json["mota"],
    );
  }


}