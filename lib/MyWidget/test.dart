import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:selforder_food/cart.dart';
import 'package:selforder_food/ipdata.dart';

import '../singleview.dart';

class GdTest extends StatefulWidget {
  const GdTest({Key? key,}) : super(key: key);
  //
  // final String image;
  // final String food_name;
  // final int price;

  @override
  State<GdTest> createState() => _GdTestState();
}

class _GdTestState extends State<GdTest> {

   Future<dynamic> getData()async{
       Response response=await get(Uri.parse("http://192.168.98.135/php/self_order/API/view_food_api.php"));
       if(response.statusCode == 200){
         var data=jsonDecode(response.body);
         var result= data;
         print(result);
         return result;
         print(result);
       }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232227),


      body: FutureBuilder(
        future: getData(),
        builder: (context,AsyncSnapshot snapshot) {
           if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
               child: CircularProgressIndicator(),
             );
           }

         if(snapshot.hasData){
           return GridView.builder(
             itemCount: snapshot.data["data"].length,
             gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 ),
             itemBuilder: (context, index) {
               return Container(
                 padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color: Color(0xFF232227),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.4),
                         spreadRadius: 1,
                         blurRadius: 4,
                       )
                     ]),
                 child: Column(
                   children: [
                     InkWell(
                       onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(
                           builder: (context) => Singleitemview(food_id: snapshot.data["data"][index]["food_id"], price: snapshot.data["data"][index]["price"],),
                         ));
                       },
                       child: Container(

                         child: Image.network("${ipData.ip}/${ipData.image}/${snapshot.data["data"][index]["photo"]}"
                           ,
                           width: 120,
                           height: 120,
                           fit: BoxFit.cover,
                         ),
                       ),
                     ),
                     Container(
                       alignment: Alignment.centerLeft,
                       child: Text(
                           snapshot.data["data"][index]["food_name"],
                           style: GoogleFonts.vinaSans(color: Colors.white,fontSize: 20)
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
    );
  }
}
