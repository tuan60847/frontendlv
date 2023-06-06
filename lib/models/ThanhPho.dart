class ThanhPho{
  int MaTP;
  String  TenTP;

  ThanhPho({required this.MaTP, required this.TenTP});

  Map<String, dynamic> toJson() {
    return {
      'MaTP': MaTP,
      'TenTP': TenTP,
    };
  }

  factory ThanhPho.fromJson(Map<String, dynamic> json){
    return ThanhPho(
      MaTP: json["MaTP"],
      TenTP: json["TenTP"],
    );
  }


}