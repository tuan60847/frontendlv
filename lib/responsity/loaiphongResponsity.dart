

import 'package:frontendlv/models/loaiphong.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<loaiphong>> getDataLoaiPhong() async {
  String urilink = "${HTTP.link}loaiphong";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => loaiphong.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<List<loaiphong>> getLoaiPhongByUIDKS(String UIDKS) async {
  String urilink = "${HTTP.link}loaiphong/findbyKS/$UIDKS";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => loaiphong.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<loaiphong> getLoaiPhong(String UIDKS) async {
  String urilink = "${HTTP.link}loaiphong/${UIDKS.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return loaiphong.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> deleteLoaiPhong(loaiphong LoaiPhong) async {
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

Future<bool> insertloaiphong(loaiphong loaiphong) async {
  String urilink = "${HTTP.link}loaiphong";
  final response = await http.post(Uri.parse(urilink), body: {
    'UIDLoaiPhong': loaiphong.UIDLoaiPhong.toString(),
    'TenLoaiPhong': loaiphong.TenLoaiPhong.toString(),
    'Gia': loaiphong.Gia.toString(),
    'UIDKS': loaiphong.UIDKS.toString(),
    'soGiuong': loaiphong.soGiuong.toString(),
    'phongConLai': loaiphong.phongConLai.toString(),
    'isMayLanh': loaiphong.isMayLanh.toString(),
  });
  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> updateloaiphong(loaiphong loaiphong) async {
  String urilink = "${HTTP.link}loaiphong/${loaiphong.UIDLoaiPhong}";
  final response = await http.put(Uri.parse(urilink), body: {
    'TenLoaiPhong': loaiphong.TenLoaiPhong.toString(),
    'Gia': loaiphong.Gia.toString(),
    'UIDKS': loaiphong.UIDKS.toString(),
    'soGiuong': loaiphong.soGiuong.toString(),
    'phongConLai': loaiphong.phongConLai.toString(),
    'isMayLanh': loaiphong.isMayLanh.toString(),
  });
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}
