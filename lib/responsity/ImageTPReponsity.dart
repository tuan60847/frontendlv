import 'dart:io';


import 'package:frontendlv/models/ImageThanhPho.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ImageTP>> getDataImageTP() async {
  String urilink = "${HTTP.link}hinhanhtp";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ImageTP.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<List<ImageTP>> getImageTP(String MaTP) async {
  String urilink = "${HTTP.link}hinhanhtp/UIDThanhPho/${MaTP.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ImageTP.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}


Future<bool> deleteImageTP(String imageTP) async {
  String urilink = "${HTTP.link}hinhanhtp/image/thanhpho/${imageTP}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 204) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> uploadImageTP(int MaTP, File file) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('${HTTP.link}image/hinhanhloaiphong/upload'));

  request.fields['MaTP'] = MaTP.toString();

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

