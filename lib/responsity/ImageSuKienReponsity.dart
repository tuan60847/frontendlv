import 'dart:io';



import 'package:frontendlv/models/ImageSuKien.dart';
import 'package:frontendlv/values/app_http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ImageSuKien>> getDataImageSuKien() async {
  String urilink = "${HTTP.link}hinhanhSK";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ImageSuKien.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}

Future<List<ImageSuKien>> getImageSuKien(String MaSuKien) async {
  String urilink = "${HTTP.link}hinhanhSK/UIDSK/${MaSuKien.toString()}";
  final response = await http.get(Uri.parse(urilink));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result;
    return list.map((e) => ImageSuKien.fromJson(e)).toList();
  } else {
    throw Exception("Fail to load");
  }
}


Future<bool> deleteImageSuKien(String ImageSuKien) async {
  String urilink = "${HTTP.link}hinhanhSK/image/SuKien/${ImageSuKien}";
  final response = await http.delete(
    Uri.parse(urilink),
  );
  if (response.statusCode == 204) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> uploadImageSuKien(int MaSuKien, File file) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('${HTTP.link}image/hinhanhSK/upload'));

  request.fields['MaSuKien'] = MaSuKien.toString();

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

