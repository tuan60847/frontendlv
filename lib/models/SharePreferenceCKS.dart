import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'ChuKhachSan.dart';

class SharedPreferencesServiceChuKhachSan {
  static const _keyChuKhachSan= 'ChuKhachSan';

  static Future<bool> saveChuKhachHang(ChuKhachSan chuKhachSan) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonChuKhachSan = json.encode(chuKhachSan.toJson());
    return prefs.setString(_keyChuKhachSan, jsonChuKhachSan);
  }

  static Future<ChuKhachSan?> getKhachHang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonChuKhachSan = prefs.getString(_keyChuKhachSan);
    if (jsonChuKhachSan != null) {
      final Map<String, dynamic> map = json.decode(jsonChuKhachSan);
      return ChuKhachSan.fromJson(map);
    }
    return null;
  }
}