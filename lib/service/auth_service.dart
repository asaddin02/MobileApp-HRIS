import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthUser {
  final String url = 'http://192.168.1.8:8000/api/';
  postData(data, apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: setHeaders());
  }

  getUser() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    final String? token = pre.getString("auth");
    var fullUrl = "${url}profile";
    var response = await http
        .get(Uri.parse(fullUrl), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      String responseBody = response.body;
      Map<String, dynamic> userData = jsonDecode(responseBody);
      return userData;
    } else {
      return "Data gagal dimuat";
    }
  }

  getpresensi() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    final String? token = pre.getString("auth");
    var fullUrl = "${url}getabsensis";
    var response = await http
        .get(Uri.parse(fullUrl), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      String responseBody = response.body;
      Map<String, dynamic> presensi = jsonDecode(responseBody);
      return presensi;
    } else {
      return "Data gagal dimuat";
    }
  }

  postPresensi(data) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    final String? token = pre.getString("auth");
    var fullUrl = "${url}safeabsensi";
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        });
  }

  editData(data) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    final String? token = pre.getString("auth");
    var fullUrl = "${url}profile";
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: {
          'Authorization': 'Bearer $token',
        });
  }

  autologin() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    final String? token = pre.getString("auth");
    if (token != null && token.isNotEmpty) {
      true;
    } else {
      false;
    }
  }

  setHeaders() => {'Content-Type': 'application/json'};
}
