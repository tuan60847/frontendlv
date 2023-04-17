import 'dart:io';


import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/ImageLoaiPhong.dart';

Future<List<ImageLoaiPhong>> getDataImageLoaiPhong() async {
  String urilink = "${HTTP.link}hinhanhloaiphong";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ImageLoaiPhong.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<List<ImageLoaiPhong>> getImageLoaiPhong(String UIDLoaiPhong) async {
  String urilink = "${HTTP.link}hinhanhloaiphong/UIDLoaiPhong/${UIDLoaiPhong.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ImageLoaiPhong.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}


Future<bool> deleteImageLoaiPhong(String imageKS) async {
  String urilink = "${HTTP.link}hinhanhloaiphong/${imageKS}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 204) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> uploadImageLoaiPhong(int UIDLoaiPhong,File file) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('${HTTP.link}image/hinhanhloaiphong/upload'));

  request.fields['UIDLoaiPhong'] = UIDLoaiPhong.toString();

  if (file != null) {
    request.files.add(await http.MultipartFile.fromPath(
        'image', file.path,
        filename: file.path.split('/').last));
  }

  var response = await request.send();
  if (response.statusCode == 201) {
    return true;
  } else {
    print('Image upload failed with code ${response.statusCode}');
    return false;
  }
}



