import 'package:frontendlv/Control/ConverEntity.dart';

class KhachHang{
  final String email;
  final String password;
  late String HoTen;
  final String cmnd;
  final String SDT;
  late String ChuoiNgaySinh;
  late bool isDatPhong;
  late String isAdminKH;
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
      'isDatPhong':ChuoiNgaySinh,
      'isDatPhong':isDatPhong,
      'isAdminKH':isAdminKH
    };
  }


  
  KhachHang({ required this.email,required this.password,required this.HoTen,required this.cmnd,required this.SDT,
    required this.ChuoiNgaySinh, this.isDatPhong=false, this.isAdminKH=""});

  factory KhachHang.fromJson(Map<String, dynamic> json){
    return KhachHang(
        email: json["Email"],
        password: json["Password"],
        HoTen:json["HoTen"],
        cmnd:json["cmnd"],
        SDT:json["SDT"],
        ChuoiNgaySinh:json["NgaySinh"],
        isDatPhong:json["isDatPhong"],
        isAdminKH:json["isAdminKH"],
    );

  }
}