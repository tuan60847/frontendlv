import 'package:frontendlv/models/ThanhPho.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ThanhPho>> getDataThanhpho() async {
  String urilink = "${HTTP.link}thanhpho";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ThanhPho.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<ThanhPho> getThanhPho(String mathanhpho) async {
  String urilink = "${HTTP.link}thanhpho/${mathanhpho.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return ThanhPho.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}

Future<ThanhPho> getThanhPhoByTen(String TenTP) async {
  String urilink = "${HTTP.link}thanhpho/getbyname/${TenTP.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return ThanhPho.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}