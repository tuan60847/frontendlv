import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'KhachHang.dart';

class SharedPreferencesService {
  static const _keyKhachHang = 'khachHang';

  static Future<bool> saveKhachHang(KhachHang khachHang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonKhachHang = json.encode(khachHang.toJson());
    return prefs.setString(_keyKhachHang, jsonKhachHang);
  }

  static Future<KhachHang?> getKhachHang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonKhachHang = prefs.getString(_keyKhachHang);
    if (jsonKhachHang != null) {
      final Map<String, dynamic> map = json.decode(jsonKhachHang);
      return KhachHang.fromJson(map);
    }
    return null;
  }
}