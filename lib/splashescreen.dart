import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:selforder_food/BottomNav.dart';
import 'package:selforder_food/hom3.dart';
import 'package:selforder_food/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userLoginCred = pref.getBool('u_log');
    if(userLoginCred ==true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav(),));
      Fluttertoast.showToast(msg: "Come on lets try it");
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
      Fluttertoast.showToast(msg: "Please login");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5)).whenComplete(() => checkLogin());

  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/Animation - 1700712033224.json",width: 1000,height: 1000),
      ),

    );
  }
}
