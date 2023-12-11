import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:selforder_food/modelclass/orderviewmodelclass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cartprovider extends ChangeNotifier{
  var remove;
  var id;
  var result;
  Future <Orderviewmodelclass>cartList()async{
    var data={"id":id.toString()};
    Response response =await post(Uri.parse("http://192.168.173.135/php/self_order/API/order_view2.php"),body:data );
    if(response.statusCode==200){
result=Orderviewmodelclass.fromJson(jsonDecode(response.body));

    }
    notifyListeners();
    return result;
  }

  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result =  sharedPreferences.getInt("user");

      id = result.toString();
      notifyListeners();

  }

  Future removeOrder({required id})async{
    var data={"order_id":id};
    Response response=await  post(Uri.parse("http://192.168.173.135/php/self_order/API/remove_order_api.php"),body: data);
    if(response.statusCode==200){
      remove=jsonDecode(response.body);
      Fluttertoast.showToast(msg: "Removed");

    }
    notifyListeners();

  }

}