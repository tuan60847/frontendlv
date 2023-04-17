import 'package:frontendlv/models/DonDatPhong.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<DonDatPhong>> getDataDonDatPhong() async {
  String urilink = "${HTTP.link}dondatphong";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => DonDatPhong.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<List<DonDatPhong>> getDataDonDatPhongProcessing() async {
  String urilink = "${HTTP.link}dondatphong/processing/dondatphong";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => DonDatPhong.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<DonDatPhong> getNewDonDatPhongByEmail(String Email) async {
  String urilink = "${HTTP.link}dondatphong/findlastbyEmail/${Email.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return DonDatPhong.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}

Future<DonDatPhong> getDonDatPhong(String UIDKS) async {
  String urilink = "${HTTP.link}dondatphong/${UIDKS.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return DonDatPhong.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}



Future<bool> deleteDonDatPhong(DonDatPhong donDatPhong) async {
  String urilink = "${HTTP.link}dondatphong/${donDatPhong.UIDDatPhong}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> insertDonDatPhong(DonDatPhong donDatPhong) async {
  String urilink = "${HTTP.link}dondatphong";
  final response =
  await http.post(Uri.parse(urilink), body: {

    "UIDDatPhong": donDatPhong.UIDDatPhong.toString(),
    "EmailKH": donDatPhong.EmailKH.toString(),
    "NgayDatPhong": donDatPhong.NgayDatPhong.toString(),
    "isChecked": donDatPhong.isChecked.toString(),
    "TienCoc": donDatPhong.TienCoc.toString(),
    "tongtien": donDatPhong.tongtien.toString(),

  });
  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> updateDonDatPhong(DonDatPhong donDatPhong) async {
  String urilink = "${HTTP.link}dondatphong/${donDatPhong.UIDDatPhong}";
  final response = await http.put(Uri.parse(urilink), body: {
    "EmailKH": donDatPhong.EmailKH.toString(),
    "NgayDatPhong": donDatPhong.NgayDatPhong.toString(),
    "isChecked": donDatPhong.isChecked.toString(),
    "TienCoc": donDatPhong.TienCoc.toString(),
    "tongtien": donDatPhong.tongtien.toString(),
  });
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}
