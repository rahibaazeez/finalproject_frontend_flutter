import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selforder_food/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyWidget/new_navbar.dart';
import 'login.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  void checkLogin()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    final userLogin=preferences.getBool('u_log');
    if(userLogin==true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomenavBar()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
      Fluttertoast.showToast(msg: "Please login");
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.orangeAccent ,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50))),
                  child: Column(
                    children: [
                      Expanded(

                          child: Image.asset("assets/chef.jpg"))
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.orangeAccent,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color(0xFF232227),
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Come and Tast it",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold,color: Colors.orangeAccent),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Enjoy with our deliciuos foods',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                wordSpacing: 1.5,
                                fontSize: 16,
                                color: Colors.orangeAccent,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            //button position
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                height: 60,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                color: Colors.orangeAccent,
                                onPressed: () {
                                  //home screen path
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()));

                                },
                                child: Text(
                                  "Lets try it!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFF232227)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
