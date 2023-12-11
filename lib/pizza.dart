

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:selforder_food/ipdata.dart';
import 'package:selforder_food/provider/homeprovider.dart';
import 'package:selforder_food/singleview.dart';

class Pizza extends StatelessWidget {
  const Pizza({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232227),


      body: FutureBuilder(
          future:  Provider.of<Homeprovider>(context,listen: false).pizzaView(),
          builder: (context,AsyncSnapshot snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
if(snapshot.hasData){

  return GridView.builder(
    itemCount: snapshot.data["data"].length,
    gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 ),
    itemBuilder: (context, index) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF232227),
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
                  builder: (context) => Singleitemview(foodId: snapshot.data["data"][index]["food_id"], price: snapshot.data["data"][index]["price"],),
                ));
              },
              child: Image.network("${ipData.ip}/${ipData.image}/${snapshot.data["data"][index]["photo"]}"
                ,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
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
  return const Center(
    child: Text("Something wrong"),
  );
}
          }
      ),
    );
  }
}
