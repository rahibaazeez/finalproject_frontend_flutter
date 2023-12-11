import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BottomNav.dart';

class Loginprovider extends ChangeNotifier{
  int id = 0;
  var data1;
  var result;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool secure = true;
  GlobalKey<FormState> formkey = GlobalKey();
  Future logIn({required email,required password,required BuildContext context}) async {
    var data = {"email": email, "password": password};
    Response response = await post(
      Uri.parse("http://192.168.173.135/php/self_order/API/get_user_api.php"),
      body: data,
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result["data"] == null) {
        Fluttertoast.showToast(msg: "Please register");
      } else {
        id = int.parse(result["data"]["id"]);
        userCrenditails();
        Fluttertoast.showToast(msg: "Welcome");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=> const BottomNav()));
      }
    }
    notifyListeners();
  }
  userCrenditails()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.setInt("user", id);
    sharedPreferences.setBool('u_log', true);
    notifyListeners();
  }
  void security(){
    secure=!secure;

  }
  void clear(){
    email.clear();
    password.clear();
  }

}