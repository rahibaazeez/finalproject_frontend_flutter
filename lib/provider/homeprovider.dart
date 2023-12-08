import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modelclass/viewfoodmodel.dart';

class Homeprovider extends ChangeNotifier{
  var data;
  var result;
  var image;
  String? user_id;
  Future getUser() async {
    var user = {"id":user_id.toString()};

    Response response=await post(Uri.parse("http://192.168.173.135/php/self_order/API/view_user_api.php"),body: user);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);

        image=data["data"]["photo"];
        return image;

    }
    notifyListeners();

  }

  Future userCrenditails()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var result=await sharedPreferences.getInt("user");
      user_id=result.toString();

    notifyListeners();
  }

  Future<FoodviewModel> getData()async{
    Response response=await get(Uri.parse("${ipData.ip}/php/self_order/API/view_food_api.php"));

    if(response.statusCode == 200){
        result = FoodviewModel.fromJson(jsonDecode(response.body));
      notifyListeners();

    }

    return result;
  }
  Future<dynamic> pizzaView()async{
    Response response=await get(Uri.parse("http://192.168.173.135/php/self_order/API/pizza_view_api.php"));
    if(response.statusCode == 200){
       data=jsonDecode(response.body);
      result= data;
      return result;

    }
    notifyListeners();
  }
  Future<dynamic> burgerView()async{
    Response response=await get(Uri.parse("http://192.168.173.135/php/self_order/API/burger_view_api.php"));
    if(response.statusCode == 200){
      var data=jsonDecode(response.body);
      var result= data;
      return result;


    }
    notifyListeners();
  }
  Future<dynamic> drinksView()async{
    Response response=await get(Uri.parse("http://192.168.173.135/php/self_order/API/drinks_view_api.php"));
    if(response.statusCode == 200){
      var data=jsonDecode(response.body);
      var result= data;
      return result;

    }
    notifyListeners();
  }


}