import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future cartList()async{
    var data={"id":id.toString()};
    Response response =await post(Uri.parse("http://192.168.98.135/php/self_order/API/order_view2.php"),body:data );
    print(response.body);
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print(data);
      return data;
    }
  }
  var id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user");
    setState(() {
      id = result.toString();
    });
    print("dat2 is ${id}");
  }
  var remove;
  Future removeOrder({required id})async{
    var data={"o_id":id};
    Response response=await  post(Uri.parse("http://192.168.98.135/php/self_order/API/remove_order_api.php"),body: data);
    if(response.statusCode==200){
      remove=jsonDecode(response.body);
      setState(() {

      });
    }

  }


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      userCrenditails();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232227),
      appBar: AppBar(
        backgroundColor: Color(0xFF232227),
        title: Text("Cart",style: TextStyle(color: Colors.orangeAccent,fontSize: 25),),
      ),
      body: FutureBuilder(
          future: cartList(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }if(snapshot.hasData){
              return ListView.builder(

                  itemCount: snapshot.data["data"].length,
                  itemBuilder: (context,index) {
                    return ListTile(
                      tileColor: Colors.orangeAccent,
                      textColor: Colors.black,

                      title: Text(snapshot.data["data"][index]["food_name"]),
                      subtitle: Text(snapshot.data["data"][index]["order_date"]),
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage('${ipData.ip}/${ipData.image}/${snapshot.data["data"][index]["photo"]}'),

                      ),



                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black
                        ),

                        onPressed: (){

                        print(snapshot.data["data"][index]["order_id"]);
                       removeOrder(id:snapshot.data["data"][index]["order_id"]);
                       },child:Text("Remove",style: TextStyle(color: Colors.orangeAccent),),),
                    );
                  }
              );
            }else{
              return Center(
                child:Text("Something went wrong") ,
              );
            }

          }
          ),


    );
  }
}
