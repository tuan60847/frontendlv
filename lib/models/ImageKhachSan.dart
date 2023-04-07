class ImageKS{
  final String src;
  final String UIDKS;

  ImageKS({required this.src,required this.UIDKS});
  factory ImageKS.fromJson(Map<String, dynamic> json){
    return ImageKS(
      src: json["src"],
      UIDKS: json["UIDKS"],
    );
  }
}