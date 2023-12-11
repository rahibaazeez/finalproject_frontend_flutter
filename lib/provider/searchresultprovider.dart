import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:selforder_food/modelclass/searchresultmodelclass.dart';

class Searchresultprovider extends ChangeNotifier{
  var foodId;
  String? price;
  var result;

  Future<Searchresultmodelclass> searchView(foodid,price)async{
    var data={"food_id":foodid,"price":price

    };
    Response response=await post(Uri.parse("http://192.168.173.135/php/self_order/API/single_view_api.php"),body: data);
    if(response.statusCode == 200){
      result= Searchresultmodelclass.fromJson(jsonDecode(response.body));


    }

    notifyListeners();
    return result;
  }
}