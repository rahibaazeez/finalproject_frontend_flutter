import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class Profileprovider extends ChangeNotifier{

  var img ;
  String? userId;
  Future getUser(BuildContext context) async {

    var user = {"id":userId.toString()};
    try {
      Response response = await post(
          Uri.parse("http://192.168.173.135/php/self_order/API/view_user_api.php"),
          body: user);

      if (response.statusCode == 200) {
        var data1 = jsonDecode(response.body);

        if (data1 != null && data1["data"] != null) {

            img = data1["data"]["Photo"];
          var  data = data1;

          return data;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(""),

            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load user data"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred"),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  Future userCrenditails()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var result= sharedPreferences.getInt("user");

      userId=result.toString();
    notifyListeners();
  }
}

