class ImageSuKien{
  final String src;
  final int MaSuKien;

  ImageSuKien({required this.src,required this.MaSuKien});
  factory ImageSuKien.fromJson(Map<String, dynamic> json){
    return ImageSuKien(
      src: json["src"],
      MaSuKien: json["MaSuKien"],
    );
  }
}