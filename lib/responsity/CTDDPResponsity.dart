import 'package:frontendlv/models/CTDDP.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<CTDDP>> getDataCTDDP() async {
  String urilink = "${HTTP.link}dondatphong";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => CTDDP.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<List<CTDDP>> getCTDDPByMaDP(String MaDP) async {
  String urilink = "${HTTP.link}ctddp/findbyMaDDP/${MaDP.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => CTDDP.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}





Future<bool> deleteCTDDP(CTDDP donDatPhong) async {
  String urilink = "${HTTP.link}ctddp/${donDatPhong.UIDCTDDP.toString()}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> insertCTDDP(CTDDP ctddp) async {
  String urilink = "${HTTP.link}ctddp";
  final response =
  await http.post(Uri.parse(urilink), body: {

    "UIDCTDDP":  ctddp.UIDCTDDP.toString(),
    "MaDDP":  ctddp.MaDDP.toString(),
    "UIDLoaiPhong":  ctddp.UIDLoaiPhong.toString(),
    "SoNgayO":  ctddp.SoNgayO.toString(),
    "soLuongPhong":  ctddp.soLuongPhong.toString(),
    "Tien":  ctddp.Tien.toString(),

  });
  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> updateCTDDP(CTDDP ctddp) async {
  String urilink = "${HTTP.link}ctddp/${ctddp.UIDCTDDP}";
  final response = await http.put(Uri.parse(urilink), body: {
    "MaDDP":  ctddp.MaDDP.toString(),
    "UIDLoaiPhong":  ctddp.UIDLoaiPhong.toString(),
    "SoNgayO":  ctddp.SoNgayO.toString(),
    "soLuongPhong":  ctddp.soLuongPhong.toString(),
    "Tien":  ctddp.Tien.toString(),
  });
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}
