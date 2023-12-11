
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BottomNav.dart';
import '../login.dart';

class Splashscreenprovider extends ChangeNotifier{
  void checkLogin(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userLoginCred = pref.getBool('u_log');
    if(userLoginCred ==true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav(),));
      Fluttertoast.showToast(msg: "Come on lets try it");
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login(),));
      Fluttertoast.showToast(msg: "Please login");
    }
    notifyListeners();
  }
}