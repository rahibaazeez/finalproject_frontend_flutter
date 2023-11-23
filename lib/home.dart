import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:selforder_food/ipdata.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var result;
  Future viewData()async{
    Response response=await get(Uri.parse("http://192.168.1.36/php/self_order/API/view_food_api.php"));

    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print('success');
      setState(() {
        result=data;
      });

      return result;
    }else{
      print('failed');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food items"),
       actions: [Padding(
         padding: const EdgeInsets.only(right: 30),
         child: Icon(Icons.shopping_cart),
       )],
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: viewData(),
        builder: (context,AsyncSnapshot snapshot) {
          return ListView.builder(
            itemBuilder: (context,index) {
              return Column(
                children: [
                  Text(snapshot.data["data"][index]["food_name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  SizedBox(height: 20,),
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("${ipData.ip}/${ipData.image}/${snapshot.data["data"][index]["photo"]}")
                      )
                    ),

                    ),

                  Text(snapshot.data["data"][index]["ingredients"],style: TextStyle(fontSize: 20),),
                  Text(snapshot.data["data"][index]["preparationtime"].toString(),style: TextStyle(fontSize: 20),),
                  Text(snapshot.data["data"][index]["price"].toString(),style: TextStyle(fontSize: 20),),
                  SizedBox(height: 30),
              ElevatedButton(
              onPressed: (){},child: Text("Book now"),

              ),
                  SizedBox(height: 20,)
                ],

              );
            }
          );
        }
      ),

    );
  }
}
