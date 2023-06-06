import 'package:frontendlv/models/ChuKhachSan.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ChuKhachSan>> getDataChuKhachSan() async {
  String urilink = "${HTTP.link}/chukhachsan";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ChuKhachSan.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<ChuKhachSan> getChuKhachSan(String Email) async {
  String urilink = "${HTTP.link}chukhachsan/${Email.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return ChuKhachSan.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}

// Future<bool> getIsAdmin(String Email) async {
//   String urilink = "${HTTP.link}khachhang/adminkh/${Email.toString()}";
//   final response = await http.get(Uri.parse(urilink));
//   if (response.statusCode == 200) {
//     // final result = jsonDecode(response.body);
//     // Iterable list = result;
//     return true;
//   } else {
//     return false;
//   }
// }

// Future<bool> getSetON(String Email) async {
//   String urilink = "${HTTP.link}khachhang/seton/${Email.toString()}";
//   final response = await http.get(Uri.parse(urilink));
//   if (response.statusCode == 200) {
//     // final result = jsonDecode(response.body);
//     // Iterable list = result;
//     return true;
//   } else {
//     return false;
//   }
// }
//
// Future<bool> getSetOFF(String Email) async {
//   String urilink = "${HTTP.link}khachhang/setoff/${Email.toString()}";
//   final response = await http.get(Uri.parse(urilink));
//   if (response.statusCode == 200) {
//     // final result = jsonDecode(response.body);
//     // Iterable list = result;
//     return true;
//   } else {
//     return false;
//   }
// }



Future<bool> deleteChuKhachSan(ChuKhachSan ChuKhachSan) async {
  String urilink = "${HTTP.link}chukhachsan/${ChuKhachSan.email}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> insertChuKhachHang(ChuKhachSan chuKhachSan) async {
  String urilink = "${HTTP.link}chukhachsan";
  final response =
  await http.post(Uri.parse(urilink), body: {
    "Email": chuKhachSan.email.toString(),
    "Password": chuKhachSan.password.toString(),
    "HoTen": chuKhachSan.HoTen.toString(),
    "NgaySinh": chuKhachSan.ChuoiNgaySinh.toString(),
    "SDT": chuKhachSan.SDT.toString(),
    "cmnd": chuKhachSan.cmnd.toString(),
    "isAdminKH": "",
  });
  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> updateCKS(ChuKhachSan chuKhachSan) async {
  String urilink = "${HTTP.link}chukhachsan/${chuKhachSan.email}";
  final response = await http.put(Uri.parse(urilink), body: {
    "Password": chuKhachSan.password.toString(),
    "HoTen": chuKhachSan.HoTen.toString(),
    "NgaySinh": chuKhachSan.ChuoiNgaySinh.toString(),
    "SDT": chuKhachSan.SDT.toString(),
    "cmnd": chuKhachSan.cmnd.toString(),
    "isAdminKH": "",
    // "isAdminKH": khachHang.isAdminKH.toString(),
  });
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}
