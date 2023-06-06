import 'package:frontendlv/models/KhachHang.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<KhachHang>> getData() async {
  String urilink = "${HTTP.link}/khachhang";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => KhachHang.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<KhachHang> getKhachHang(String Email) async {
  String urilink = "${HTTP.link}khachhang/${Email.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return KhachHang.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> getIsAdmin(String Email) async {
  String urilink = "${HTTP.link}khachhang/adminkh/${Email.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    // final result = jsonDecode(response.body);
    // Iterable list = result;
    return true;
  } else {
    return false;
  }
}

Future<bool> getSetON(String Email) async {
  String urilink = "${HTTP.link}khachhang/seton/${Email.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    // final result = jsonDecode(response.body);
    // Iterable list = result;
    return true;
  } else {
    return false;
  }
}

Future<bool> getSetOFF(String Email) async {
  String urilink = "${HTTP.link}khachhang/setoff/${Email.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    // final result = jsonDecode(response.body);
    // Iterable list = result;
    return true;
  } else {
    return false;
  }
}



Future<bool> deleteKhachHang(KhachHang khachHang) async {
  String urilink = "${HTTP.link}khachhang/${khachHang.email}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> insertKhachHang(KhachHang khachHang) async {
  String urilink = "${HTTP.link}khachhang";
  final response =
      await http.post(Uri.parse(urilink), body: {
    "Email": khachHang.email.toString(),
    "Password": khachHang.password.toString(),
    "HoTen": khachHang.HoTen.toString(),
    "NgaySinh": khachHang.ChuoiNgaySinh.toString(),
    "SDT": khachHang.SDT.toString(),
    "cmnd": khachHang.cmnd.toString(),
    "isDatPhong": khachHang.isDatPhong.toString(),
    "isAdminKH": "",
  });
  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> updateKH(KhachHang khachHang) async {
  String urilink = "${HTTP.link}khachhang/${khachHang.email}";
  final response = await http.put(Uri.parse(urilink), body: {
    "Password": khachHang.password.toString(),
    "HoTen": khachHang.HoTen.toString(),
    "NgaySinh": khachHang.ChuoiNgaySinh.toString(),
    "SDT": khachHang.SDT.toString(),
    "cmnd": khachHang.cmnd.toString(),
    "isDatPhong": khachHang.isDatPhong ? 1 : 0,
    // "isAdminKH": khachHang.isAdminKH.toString(),
  });
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}
