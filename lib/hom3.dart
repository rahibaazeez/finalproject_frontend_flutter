import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/MyWidget/test.dart';
import 'package:selforder_food/burger.dart';
import 'package:selforder_food/drinks.dart';
import 'package:selforder_food/feedback.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/pizza.dart';
import 'package:selforder_food/profile.dart';
import 'package:selforder_food/provider/homeprovider.dart';
import 'package:selforder_food/provider/loginprovider.dart';
import 'package:selforder_food/provider/profileprovider.dart';
import 'package:selforder_food/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MyWidget/new_widget.dart';
import 'cart.dart';
import 'login.dart';

class Home3 extends StatelessWidget {
  const Home3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<Homeprovider>(context,listen: false).userCrenditails();
    Provider.of<Profileprovider>(context, listen: false).getUser(context);
    Provider.of<Homeprovider>(context,listen: false).getData();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search( )));
              },
                child: Icon(Icons.search,)),
          )],

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
                        image: NetworkImage("${ipData.ip}/${ipData.image2}/${Provider.of<Profileprovider>(context).img}"),
                        fit: BoxFit.fill

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
                    Navigator.of(context).push(MaterialPageRoute(
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
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => FeedBack(),
                    ));
                  },
                  title: Text("Feedback"),
                  leading: Icon(Icons.feedback),
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
