import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:selforder_food/BottomNav.dart';
import 'package:selforder_food/MyWidget/singleview_navbar.dart';
import 'package:selforder_food/cart.dart';
import 'package:selforder_food/hom3.dart';
import 'package:selforder_food/ipdata.dart';

class Singleitemview extends StatefulWidget {
  String food_id;
  String price;
Singleitemview({required this.food_id,required this.price});


  @override
  _SingleitemviewState createState() => _SingleitemviewState();
}

class _SingleitemviewState extends State<Singleitemview> {
  Future<dynamic> singleView()async{
    var data={
      "food_id":widget.food_id
    };
    Response response=await post(Uri.parse("http://192.168.98.135/php/self_order/API/single_view_api.php"),body: data);
    if(response.statusCode == 200){
      var data=jsonDecode(response.body);
      var result= data;
      print(result);
      return result;
      print(result);
    }
  }
  // Track the quantity of the food item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(leading: InkWell(onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BottomNav()));
      },
          child: Icon(Icons.arrow_back,color: Colors.orangeAccent,)),
      backgroundColor: Colors.black,),
      body: FutureBuilder(
          future: singleView(),
          builder: (context,AsyncSnapshot snapshot) {
            // if(snapshot.connectionState==ConnectionState.waiting){
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        Center(
                          child: Container(

                            child: Image.network("${ipData.ip}/${ipData.image}/${snapshot.data["data"][index]["photo"]}",
                              height: 400,
                              width: 350,


                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
SizedBox(height: 20,),
                        Center(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                snapshot.data["data"][index]["food_name"],
                                style: GoogleFonts.vinaSans(color: Colors.black,fontSize: 20)
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text("Ingredients included",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              snapshot.data["data"][index]["ingredients"],
                              style: GoogleFonts.vinaSans(color: Colors.black,fontSize: 20)
                          ),
                        ),


                      ],
                    ),
                  );

                },);
            }else{
              return Center(
                child: Text("Something wrong"),
              );
            }
          }
      ),
      bottomNavigationBar: SingleviewNav(f_id: widget.food_id, price: widget.price,),
    );
  }
}
