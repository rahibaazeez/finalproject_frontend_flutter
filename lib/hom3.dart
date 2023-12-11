


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:selforder_food/MyWidget/test.dart';
import 'package:selforder_food/burger.dart';
import 'package:selforder_food/drinks.dart';
import 'package:selforder_food/feedback.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/pizza.dart';
import 'package:selforder_food/profile.dart';
import 'package:selforder_food/provider/homeprovider.dart';

import 'package:selforder_food/provider/profileprovider.dart';
import 'package:selforder_food/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Search( )));
              },
                child: const Icon(Icons.search,)),
          )],

          backgroundColor: Colors.orangeAccent,
        ),
        drawer: Drawer(
          shadowColor: Colors.blue,
          backgroundColor: const Color(0xFF232227),
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
                      builder: (context) => const Home3(),
                    ));
                  },
                  title: const Text("Home"),
                  leading: const Icon(Icons.home),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Cart(),
                    ));
                  },
                  title: const Text("History"),
                  leading: const Icon(Icons.group),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ));
                  },
                  title: const Text("Profile"),
                  leading: const Icon(Icons.account_circle),
                ),
              ),
              const SizedBox(
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
                  title: const Text("Feedback"),
                  leading: const Icon(Icons.feedback),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  onTap: () async{
                    SharedPreferences sharedpreferences=await SharedPreferences.getInstance();
                    sharedpreferences.setBool('u_log', false);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login(),));
                  },
                  title: const Text("Logout"),
                  leading: const Icon(Icons.logout),
                ),
              )
            ],
          ),
        ),
          backgroundColor: const Color(0xFF232227),

          body: const SafeArea(

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
