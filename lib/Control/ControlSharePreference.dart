import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/values/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void saveKhachHang(KhachHang user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Chuyển đổi đối tượng User thành chuỗi JSON
  String userJson = jsonEncode(user.toJson());

  // Lưu trữ chuỗi JSON sử dụng SharedPreferences
  await prefs.setString(ShareKeys.userKH, userJson);
}


Future<KhachHang> loadUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Đọc chuỗi JSON từ SharedPreferences
  String? userJson = prefs.getString(ShareKeys.userKH);

  // Nếu chuỗi JSON không tồn tại, trả về null
  if (userJson == null) {
    return new KhachHang(email: "-1", password: "-1", HoTen: "-1", cmnd: "-1", SDT: "-1", ChuoiNgaySinh: "-1");
  }

  // Chuyển đổi chuỗi JSON thành đối tượng User
  Map<String, dynamic> userMap = jsonDecode(userJson);
  KhachHang user = KhachHang.fromJson(userMap);

  return user;
}