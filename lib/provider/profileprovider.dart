import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profileprovider extends ChangeNotifier{
  var data;
  String? user_id;
  Future getUser(BuildContext context) async {
    var user = {"id":user_id.toString()};
    try {
      Response response = await post(
          Uri.parse("http://192.168.98.135/php/self_order/API/view_user_api.php"),
          body: user);

      if (response.statusCode == 200) {
        var data1 = jsonDecode(response.body);

        if (data1 != null && data1["data"] != null) {

            data = data1;

          return data;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(""),

            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to load user data"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred"),
          backgroundColor: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  Future userCrenditails()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var result=await sharedPreferences.getInt("user");

      user_id=result.toString();

    print("dat2 is ${user_id}");
    notifyListeners();
  }
}

