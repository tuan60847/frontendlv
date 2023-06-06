class ImageDiaDiemDuLich{
  final String src ;
  final String MaDDDL;

  ImageDiaDiemDuLich({required this.src,required this.MaDDDL});
  factory ImageDiaDiemDuLich.fromJson(Map<String, dynamic> json){
    return ImageDiaDiemDuLich(
      src: json["src"],
      MaDDDL: json["MaDDDL"],
    );
  }
}