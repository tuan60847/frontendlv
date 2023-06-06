import 'package:frontendlv/Control/ConverEntity.dart';

class ChuKhachSan{
  final String email;
  final String password;
  late String HoTen;
  final String cmnd;
  final String SDT;
  late String ChuoiNgaySinh;
  late String AdminKS;
  DateTime NgaySinh(){
    return CovertEntity().CovertStringtoDate(this.ChuoiNgaySinh);
  }
  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'Password': password,
      'HoTen':HoTen,
      'cmnd':cmnd,
      'SDT':SDT,
      'NgaySinh':ChuoiNgaySinh,
      'AdminKS':AdminKS,
    };
  }



  ChuKhachSan({ required this.email,required this.password,required this.HoTen,required this.cmnd,required this.SDT,
    required this.ChuoiNgaySinh, this.AdminKS=""});

  factory ChuKhachSan.fromJson(Map<String, dynamic> json){
    return ChuKhachSan(
      email: json["Email"],
      password: json["Password"],
      HoTen:json["HoTen"],
      cmnd:json["cmnd"],
      SDT:json["SDT"],
      ChuoiNgaySinh:json["NgaySinh"],
      AdminKS:json["ADMINKS"],
    );

  }
}