import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feedbackprovider extends ChangeNotifier{

  var userId;
  Future feedBack({required feedback, required id}) async {
    var data = {
      "id": userId,
      "feedback": feedback,
      "initial_date": DateTime.now().toString()
    };
    Response response = await post(
        Uri.parse("http://192.168.173.135/php/self_order/API/feedback_api.php"),
        body: data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Thanks for your feedback");
    }
    notifyListeners();
  }


  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result =  sharedPreferences.getInt("user");
      userId = result.toString();
      notifyListeners();

  }


}