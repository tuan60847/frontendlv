import 'dart:io';


import 'package:frontendlv/models/ImageDiaDiemDuLich.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<List<ImageDiaDiemDuLich>> getDataImageDiaDiemDuLich() async {
  String urilink = "${HTTP.link}hinhanhdddl";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ImageDiaDiemDuLich.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<List<ImageDiaDiemDuLich>> getImageDiaDiemDuLich(String UIDDDDL) async {
  String urilink = "${HTTP.link}hinhanhdddl/UIDDDDL/${UIDDDDL.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ImageDiaDiemDuLich.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}


Future<bool> deleteImageDiaDiemDuLich(String ImageDDDL) async {
  String urilink = "${HTTP.link}hinhanhdddl/image/diadiemdulich/${ImageDDDL}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 204) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> uploadImageDiaDiemDuLich(int MaDDDL,File file) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('${HTTP.link}image/hinhanhdddl/upload'));

  request.fields['MaDDDL'] = MaDDDL.toString();

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



