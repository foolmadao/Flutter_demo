import 'dart:async';
import 'dart:convert';
import 'package:flutter_demo/model/home_model.dart';
import 'package:http/http.dart' as http;

const Home_API = 'http://www.devio.org/io/flutter_app/json/home_page.json';
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(Home_API);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes)); //修复中文乱码
      return HomeModel.fromJson(result);
    } else {
      throw Exception('fail to load');
    }
  } 
}