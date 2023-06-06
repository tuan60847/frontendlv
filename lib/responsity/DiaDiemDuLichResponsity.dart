import 'package:frontendlv/models/DiaDiemDuLich.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<DiaDiemDuLich>> getDataDiaDiemDuLich() async {
  String urilink = "${HTTP.link}diadiemdulich";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => DiaDiemDuLich.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}



Future<List<DiaDiemDuLich>> getDiaDiemDuLichByMaTP(int MaTP) async {
  String urilink = "${HTTP.link}diadiemdulich/findbymatp/${MaTP.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => DiaDiemDuLich.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<DiaDiemDuLich> getDiaDiemDuLich(String MaDDDL) async {
  String urilink = "${HTTP.link}diadiemdulich/${MaDDDL.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return DiaDiemDuLich.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}



Future<bool> deleteDiaDiemDuLich(DiaDiemDuLich diaDiemDuLich) async {
  String urilink = "${HTTP.link}diadiemdulich/${diaDiemDuLich.MaDDDL}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> insertDiaDiemDuLich(DiaDiemDuLich diaDiemDuLich) async {
  String urilink = "${HTTP.link}diadiemdulich";
  final response =
  await http.post(Uri.parse(urilink), body: {
    'MaDDDL': diaDiemDuLich.MaDDDL.toString(),
    'TenDiaDiemDuLich': diaDiemDuLich.TenDiaDiemDuLich.toString(),
    'DiaChi':diaDiemDuLich.DiaChi.toString(),
    'MoTa':diaDiemDuLich.MoTa.toString(),
    'GiaTien':diaDiemDuLich.GiaTien.toString(),
    'MaTP':diaDiemDuLich.MaTP.toString(),
    'ThoiGianHoatDong':diaDiemDuLich.ThoiGianHoatDong.toString(),
  });
  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> updateDonDatPhong(DiaDiemDuLich diaDiemDuLich) async {
  String urilink = "${HTTP.link}diadiemdulich/${diaDiemDuLich.MaDDDL.toString()}";
  final response = await http.put(Uri.parse(urilink), body: {
    'TenDiaDiemDuLich': diaDiemDuLich.TenDiaDiemDuLich.toString(),
    'DiaChi':diaDiemDuLich.DiaChi.toString(),
    'MoTa':diaDiemDuLich.MoTa.toString(),
    'GiaTien':diaDiemDuLich.GiaTien.toString(),
    'MaTP':diaDiemDuLich.MaTP.toString(),
    'ThoiGianHoatDong':diaDiemDuLich.ThoiGianHoatDong.toString(),
  });
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}
