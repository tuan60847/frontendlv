

import 'package:frontendlv/models/loaiphong.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Loaiphong>> getDataLoaiPhong() async {
  String urilink = "${HTTP.link}loaiphong";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => Loaiphong.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<List<Loaiphong>> getLoaiPhongByUIDKS(String UIDKS) async {
  String urilink = "${HTTP.link}loaiphong/findbyKS/$UIDKS";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => Loaiphong.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<Loaiphong> getLoaiPhong(int UIDLoaiPhong) async {
  String urilink = "${HTTP.link}loaiphong/${UIDLoaiPhong.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return Loaiphong.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}

Future<Loaiphong> getFindLastLoaiPhong(String UIDKS) async {
  String urilink = "${HTTP.link}loaiphong/findnewKS/${UIDKS.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return Loaiphong.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> deleteLoaiPhong(Loaiphong LoaiPhong) async {
  String urilink = "${HTTP.link}loaiphong/${LoaiPhong.UIDLoaiPhong}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 204) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> insertloaiphong(Loaiphong loaiphong) async {
  String urilink = "${HTTP.link}loaiphong";
  final response = await http.post(Uri.parse(urilink), body: {
    'TenLoaiPhong': loaiphong.TenLoaiPhong.toString(),
    'Gia': loaiphong.Gia.toString(),
    'UIDKS': loaiphong.UIDKS.toString(),
    'soGiuong': loaiphong.soGiuong.toString(),
    'soLuongPhong':loaiphong.soLuongPhong.toString(),
    'isMayLanh': loaiphong.isMayLanh.toString(),
  });
  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> updateloaiphong(Loaiphong loaiphong) async {
  String urilink = "${HTTP.link}loaiphong/${loaiphong.UIDLoaiPhong}";
  final response = await http.put(Uri.parse(urilink), body: {
    'TenLoaiPhong': loaiphong.TenLoaiPhong.toString(),
    'Gia': loaiphong.Gia.toString(),
    'UIDKS': loaiphong.UIDKS.toString(),
    'soGiuong': loaiphong.soGiuong.toString(),
    'soLuongPhong':loaiphong.soLuongPhong.toString(),
    'isMayLanh': loaiphong.isMayLanh.toString(),
  });
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> updateloaiphonghave(Loaiphong loaiphong) async {
  String urilink = "${HTTP.link}loaiphong/${loaiphong.UIDLoaiPhong}";
  final response = await http.put(Uri.parse(urilink), body: {
    'TenLoaiPhong': loaiphong.TenLoaiPhong.toString(),
    'Gia': loaiphong.Gia.toString(),
    'UIDKS': loaiphong.UIDKS.toString(),
    'soGiuong': loaiphong.soGiuong.toString(),
    'soLuongPhong':loaiphong.soLuongPhong.toString(),
    'isMayLanh': loaiphong.isMayLanh.toString(),
    'phongConLai': loaiphong.phongConLai.toString(),
  });
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}
