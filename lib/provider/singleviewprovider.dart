import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:selforder_food/modelclass/singleviewmodelclass.dart';

class Singleviewprovider extends ChangeNotifier{
  var foodId;
  String? price;
  var result;

  Future<Singleviewmodelclass> singleView(foodid,price)async{
    var data={"food_id":foodid,"price":price

    };
    Response response=await post(Uri.parse("http://192.168.173.135/php/self_order/API/single_view_api.php"),body: data);
    if(response.statusCode == 200){
      result= Singleviewmodelclass.fromJson(jsonDecode(response.body));

    }
    notifyListeners();
    return result;
  }
}