import 'package:frontendlv/models/KhachSan.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<KhachSan>> getDataKS() async {
  String urilink = "${HTTP.link}khachsan";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => KhachSan.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<KhachSan> getKhachSan(String UIDKS) async {
  String urilink = "${HTTP.link}khachsan/${UIDKS.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return KhachSan.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}


Future<bool> deleteKhachSan(KhachSan khachHang) async {
  String urilink = "${HTTP.link}khachsan/${khachHang.UIDKS}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> insertKhachSan(KhachSan khachSan) async {
  String urilink = "${HTTP.link}khachsan";
  final response =
  await http.post(Uri.parse(urilink), body: {
    "UIDKS": khachSan.UIDKS.toString(),
    "TenKS": khachSan.TenKS.toString(),
    "DiaChi": khachSan.DiaChi.toString(),
    "isActive": khachSan.isActive.toString(),
    "SDT": khachSan.SDT.toString(),
    "MaDDDL": khachSan.MaDDL.toString(),
    "Buffet": khachSan.Buffet.toString(),
    "Wifi": khachSan.Wifi.toString()
  });
  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> updateKhachsan(KhachSan khachSan) async {
  String urilink = "${HTTP.link}khachsan/${khachSan.UIDKS}";
  final response = await http.put(Uri.parse(urilink), body: {
    "TenKS": khachSan.TenKS.toString(),
    "DiaChi": khachSan.DiaChi.toString(),
    "isActive": khachSan.isActive.toString(),
    "SDT": khachSan.SDT.toString(),
    "MaDDDL": khachSan.MaDDL.toString(),
    "Buffet": khachSan.Buffet.toString(),
    "Wifi": khachSan.Wifi.toString()

  });
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}
