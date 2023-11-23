import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:selforder_food/MyWidget/test.dart';
import 'package:selforder_food/burger.dart';
import 'package:selforder_food/drinks.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/pizza.dart';
import 'package:selforder_food/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyWidget/new_navbar.dart';
import 'MyWidget/new_widget.dart';
import 'cart.dart';
import 'login.dart';

class Home3 extends StatefulWidget {
  const Home3({Key? key}) : super(key: key);

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  var data;
  String? user_id;
  Future getUser() async {
    var user = {"id":user_id.toString()};

    Response response=await post(Uri.parse("http://192.168.98.135/php/self_order/API/view_user_api.php"),body: user);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      setState(() {
        image=data["data"]["Photo"];
      });
    }

  }

  Future userCrenditails()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var result=await sharedPreferences.getInt("user");
    setState(() {
      user_id=result.toString();
      print(user_id);
    });
   
  }
  var image;

  @override
  void initState() {
    userCrenditails();
    Future.delayed(Duration(seconds: 1)).whenComplete(() => getUser());
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
        ),
        drawer: Drawer(
          shadowColor: Colors.blue,
          backgroundColor: Color(0xFF232227),
          child: Column(
            children: [
              DrawerHeader(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration:
                    BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${ipData.ip}/${ipData.image2}/${image}")

                      )
                    ),
                  )),
              Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home3(),
                    ));
                  },
                  title: Text("Home"),
                  leading: Icon(Icons.home),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Cart(),
                    ));
                  },
                  title: Text("History"),
                  leading: Icon(Icons.group),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Profile(),
                    ));
                  },
                  title: Text("Profile"),
                  leading: Icon(Icons.account_circle),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  onTap: () async{
                    SharedPreferences sharedpreferences=await SharedPreferences.getInstance();
                    sharedpreferences.setBool('u_log', false);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login(),));
                  },
                  title: Text("Logout"),
                  leading: Icon(Icons.logout),
                ),
              )
            ],
          ),
        ),
          backgroundColor: Color(0xFF232227),

          body: SafeArea(

            child: Padding(
              padding: EdgeInsets.only(top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Hot and Fast food",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Delivers on time",
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 22,
                          ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TabBar(
                    isScrollable: true,
                      labelStyle: TextStyle(fontSize: 20),
                      labelPadding: EdgeInsets.symmetric(horizontal: 20),
                      tabs: [
                        Tab(text: "All"),
                        Tab(text: "Pizza"),
                        Tab(text: "Burger"),
                        Tab(text: "Drinks"),
                      ]),
                  Flexible(
                    flex: 1,
                      child: TabBarView(
                    children: [
                      GdTest(),
                      Pizza(),
                      Burger(),
                      Drinks(),

                    ],
                  ))
                ],
              ),
            ),
          ),
       // bottomNavigationBar: HomenavBar(),
      ),
    );
  }
}
