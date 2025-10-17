import 'dart:convert';

import 'package:bookia/features/auth/data/models/auth_response/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static const String kuserData = 'userData';

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static saveData(String key, dynamic value) {
    if (value is int) {
      pref.setInt(key, value);
    } else if (value is String) {
      pref.setString(key, value);
    } else if (value is bool) {
      pref.setBool(key, value);
    } else if (value is double) {
      pref.setDouble(key, value);
    } else if (value is List<String>) {
      pref.setStringList(key, value);
    }
  }

  static saveUserData(UserModel? model) {
    if (model == null) return;

    var json = model.toJson();
    var jsonToString = jsonEncode(json);
    saveData(kuserData, jsonToString);
  }

  static UserModel? getUserData() {
    String? stringdata = getData(kuserData);

    if (stringdata == null) return null;
    var stringjson = jsonDecode(stringdata);
    return UserModel.fromJson(stringjson);
  }

  static dynamic getData(String key) {
    return pref.get(key);
  }

  static remove(String key) async {
    await pref.remove(key);
  }

  // setInt(String key, int val)async{
  //   return pref.setInt(key, val);
  // }

  // int? getInt(String key){
  //   return getInt(key);
  // }

  // setString(String key, String val)async{
  //   return pref.setString(key, val);
  // }

  // String? getString(String key){
  //   return getString(key);
  // }

  // setBool(String key, bool val)async{
  //   return pref.setBool(key, val);
  // }

  // bool? getBool(bool key){
  //   return getBool(key);
  // }

  // setDouble(String key, double val)async{
  //   return pref.setDouble(key, val);
  // }

  // double? getDouble(String key){
  //   return getDouble(key);
  // }
}
