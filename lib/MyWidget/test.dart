import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:selforder_food/cart.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/modelclass/viewfoodmodel.dart';
import 'package:selforder_food/provider/homeprovider.dart';

import '../singleview.dart';

class GdTest extends StatefulWidget {
  const GdTest({Key? key,}) : super(key: key);
  @override
  State<GdTest> createState() => _GdTestState();
}

class _GdTestState extends State<GdTest> {


  @override
  Widget build(BuildContext context) {
    Provider.of<Homeprovider>(context,listen: false).getData();
    return Scaffold(
      backgroundColor: Color(0xFF232227),
      body: FutureBuilder<FoodviewModel>(
        future: Provider.of<Homeprovider>(context,listen: false).getData(),

       builder: (BuildContext context, AsyncSnapshot<FoodviewModel> snapshot) {  if(snapshot.connectionState==ConnectionState.waiting){
         return Center(
           child: CircularProgressIndicator(),
         );
       }

       if(snapshot.hasData){
         return GridView.builder(
           itemCount: snapshot.data!.data!.length,
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
                         builder: (context) => Singleitemview(food_id: snapshot.data!.data![index].foodId.toString(), price: snapshot.data!.data![index].price.toString(),),
                       ));
                     },
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                       ),

                       child: Image.network("${ipData.ip}/${ipData.image}/${snapshot.data!.data![index].photo}"
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
                         snapshot.data!.data![index].foodName.toString(),
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
         ); }}
      ),
    );
  }
}
