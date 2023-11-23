import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/MyWidget/new_navbar.dart';
import 'package:selforder_food/cart.dart';
import 'package:selforder_food/hom3.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/provider/profileprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override

  Widget build(BuildContext context) {
    Provider.of<Profileprovider>(context,listen: false).userCrenditails();
    return Scaffold(

      backgroundColor: Color(0xFF232227),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Center(child: Text("Profile",style: TextStyle(fontSize: 30),)),
      ),
      body: FutureBuilder(
        future: Provider.of<Profileprovider>(context ,listen: false).getUser(context),
        builder: (context,snapshot) {
          // if(snapshot.connectionState==ConnectionState.waiting){
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          if(snapshot.hasData){
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage("${ipData.ip}/${ipData.image2}/${snapshot.data["data"]["Photo"]}")
                          )
                      ),
                    ),
                    Text(snapshot.data["data"]["Name"],style: TextStyle(color: Colors.orangeAccent,fontSize: 40),),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Icon(Icons.call,color: Colors.orangeAccent,size: 40,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Text("Phonenumber",style: TextStyle(fontSize: 25,color: Colors.orangeAccent),),
                        )
                      ],

                    ),
                    Text(snapshot.data["data"]["Phonenumber"],style: TextStyle(color: Colors.white,fontSize: 20),),
                    SizedBox(height:50 ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Icon(Icons.email_rounded,color: Colors.orangeAccent,size: 40,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Text("Email",style: TextStyle(fontSize: 25,color: Colors.orangeAccent),),
                        )
                      ],

                    ),
                    Text(snapshot.data["data"]["Email"],style: TextStyle(color: Colors.white,fontSize: 20),),
                  ],
                ),
              ),
            );


          }else{
            return Center(
              child: Text("Something wrong"),
            );
          }

        }
      ),
      //bottomNavigationBar: HomenavBar(),
    );
  }
}
