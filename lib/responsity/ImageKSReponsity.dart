import 'dart:io';

import 'package:frontendlv/models/ImageKhachSan.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ImageKS>> getDataImageKS() async {
  String urilink = "${HTTP.link}hinhanhkhachsan";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ImageKS.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<ImageKS> getImageKS(String UIDKS) async {
  String urilink = "${HTTP.link}image/UIDKS/${UIDKS.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    // Iterable list = result;
    return ImageKS.fromJson(result);
  } else {
    throw Exception("Fail to load");
  }
}


Future<bool> deleteimageKS(ImageKS imageKS) async {
  String urilink = "${HTTP.link}hinhanhkhachsan/${imageKS.src}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 204) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> uploadImageKS(String UIDKS,File file) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('${HTTP.link}image/khachsan/upload'));

  request.fields['UIDKS'] = UIDKS;

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



