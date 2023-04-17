class ImageLoaiPhong{
  final String src;
  final int UIDLoaiPhong;


  ImageLoaiPhong({required this.src,required this.UIDLoaiPhong});

  factory ImageLoaiPhong.fromJson(Map<String, dynamic> json){
    return ImageLoaiPhong(
      src: json["src"],
      UIDLoaiPhong: json["UIDLoaiPhong"],
    );
  }
}