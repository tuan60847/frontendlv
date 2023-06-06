class ImageTP{
  final String src;
  final int MaTP;

  ImageTP({required this.src,required this.MaTP});
  factory ImageTP.fromJson(Map<String, dynamic> json){
    return ImageTP(
      src: json["src"],
      MaTP: json["MaTP"],
    );
  }
}